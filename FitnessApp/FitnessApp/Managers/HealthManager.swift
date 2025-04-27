//
//  HelthManager.swift
//  FitnessApp
//
//  Created by Harsh Rajput on 30/01/25.
//

import Foundation
import HealthKit

class HealthManager{
    
    static let shared = HealthManager()
    let healthStore = HKHealthStore()
    private init(){
        Task{
            do{
                try await requestHeathKitAccess()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func requestHeathKitAccess() async throws{
        let calories = HKQuantityType(.activeEnergyBurned)
        let exercise = HKQuantityType(.appleExerciseTime)
        let stand = HKCategoryType(.appleStandHour)
        let steps = HKQuantityType(.stepCount)
        let workout = HKSampleType.workoutType()
        
        let healthTypes: Set = [calories, exercise, stand, steps, workout]
        
        try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
    }
    
    func fetchTodayCaloriesBurned(completion: @escaping(Result<Double, Error>) -> Void) {
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                completion(.failure(URLError(.badURL)))
                return
            }
            let calorieCount = quantity.doubleValue(for: .kilocalorie())
            completion(.success(calorieCount))
        }
        healthStore.execute(query)
    }
    
    func fetchTodayExerciseTime(completion: @escaping(Result<Double, Error>) -> Void) {
        let exercise = HKQuantityType(.appleExerciseTime)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: exercise, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                completion(.failure(URLError(.badURL)))
                return
            }
            let exerciseTime = quantity.doubleValue(for: .minute())
            completion(.success(exerciseTime))
        }
        healthStore.execute(query)
    }
    
    func fetchTodayStandHours(completion: @escaping(Result<Int, Error>) -> Void) {
        let stand = HKCategoryType(.appleStandHour)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKSampleQuery(sampleType: stand, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) {  _, result, error in
            guard let samples = result as? [HKCategorySample], error == nil else{
                completion(.failure(URLError(.badURL)))
                return
            }
//            print(samples)
//            print(samples.map({$0.value}))
            let standCount = samples.filter({$0.value == 0}).count
            completion(.success(standCount))
        }
        
        healthStore.execute(query)
    }
    
    //MARK: Fitness Activity
    func fetchTodaySteps(completion: @escaping(Result<Acitvity, Error>) -> Void) {
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else{
                completion(.failure(URLError(.badURL)))
                return
            }
            print(quantity)
            let steps = quantity.doubleValue(for: .count())
            let activity = Acitvity(title: "Today Steps", subTitle: "Goal: 800", image: "figure.walk", tintColor: .green, amount: steps.formattedNumberString())
            completion(.success(activity))
        }
        healthStore.execute(query)
    }
    
    func fetchCurrentWeekWorkoutState(completion: @escaping(Result<[Acitvity], Error>) -> Void) {
        let workouts = HKSampleType.workoutType()
        let predicate = HKQuery.predicateForSamples(withStart: .startOfWeek, end: Date())
        let query = HKSampleQuery(sampleType: workouts, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { [weak self] _, result, error in
            guard let workouts = result as? [HKWorkout], let self = self, error == nil else{
                completion(.failure(URLError(.badURL)))
                return
            }
            
            var runningCount: Int = 0
            var strengthCount: Int = 0
            var soccerCount: Int = 0
            var basketballCount: Int = 0
            var kikboxingCount: Int = 0
            var stairsCount: Int = 0
            
            for workout in workouts {
                let duration = Int(workout.duration)/60
                if workout.workoutActivityType == .running{
                    runningCount += duration
                } else if workout.workoutActivityType == .traditionalStrengthTraining{
                    strengthCount += duration
                }else if workout.workoutActivityType == .soccer{
                    soccerCount += duration
                }else if workout.workoutActivityType == .basketball{
                    basketballCount += duration
                }else if workout.workoutActivityType == .kickboxing{
                    kikboxingCount += duration
                }else if workout.workoutActivityType == .stairClimbing{
                    stairsCount += duration
                }
            }
            
            completion(.success(self.generateActivitiesFromDuration(running: runningCount, strength: strengthCount, soccer: soccerCount, basketball: basketballCount, stairs: stairsCount, kickboxing: kikboxingCount)))
        }
        healthStore.execute(query)
    }
    
    func generateActivitiesFromDuration(running: Int, strength: Int, soccer: Int, basketball: Int, stairs: Int, kickboxing: Int) -> [Acitvity]{
        return [
            Acitvity(title: "Running", subTitle: "This week", image: "figure.run", tintColor: .green, amount: "\(running)"),
            Acitvity(title: "Strength Traning", subTitle: "This week", image: "dumbbell", tintColor: .blue, amount: "\(strength)"),
            Acitvity(title: "Soccer", subTitle: "This week", image: "figure.soccer", tintColor: .indigo, amount: "\(soccer)"),
            Acitvity(title: "Basketball", subTitle: "This week", image: "figure.basketball", tintColor: .green, amount: "\(basketball)"),
            Acitvity(title: "Stairstepper", subTitle: "This week", image: "figure.stair.stepper", tintColor: .green, amount: "\(stairs)"),
            Acitvity(title: "Kickboxing", subTitle: "This week", image: "figure.kickboxing", tintColor: .green, amount: "\(kickboxing)")
        ]
    }
    
    //MARK: Recent WorkOuts
    func fetchWorkoutsForMonth(month: Date, completion: @escaping (Result<[WorkOut], Error>) -> Void){
        let workout = HKSampleType.workoutType()
        let (startDate, endDate) = month.fetchMonthStartAndEndDate()
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let sortDiscripter = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(sampleType: workout, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDiscripter]) {[weak self] _, result, error in
            guard let workouts = result as? [HKWorkout], let self = self, error == nil else{
                completion(.failure(URLError(.badURL)))
                return
            }
            
            let workoutsArray = workouts.map({WorkOut(title: $0.workoutActivityType.name, image: $0.workoutActivityType.image, tintColor: $0.workoutActivityType.color, duration: "\(Int($0.duration)/60) mins", date: $0.startDate.formatWorkOutdate(), calories: $0.totalEnergyBurned?.doubleValue(for: .kilocalorie()).formattedNumberString() ?? "-" + "kcal")})
            completion(.success(workoutsArray))
        }
        healthStore.execute(query)
    }
}

extension HealthManager{
    struct YearChartDataResult{
        let ytd : [DailyStepModel]
        let oneYear : [DailyStepModel]
    }
    func fetchYTDAndOneYearChartData(completion: @escaping (Result<YearChartDataResult, Error>) -> Void) {
        // Ensure step count type exists
        guard let steps = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            completion(.failure(NSError(domain: "HealthKitError", code: -1,
                                        userInfo: [NSLocalizedDescriptionKey: "Step count type is not available"])))
            return
        }
        
        let calendar = Calendar.current
        var oneYearMonths = [DailyStepModel]()
        var ytdMonths = [DailyStepModel]()
        var completedQueries = 0
        
        // Check authorization with more detailed logging
        healthStore.getRequestStatusForAuthorization(toShare: [steps], read: [steps]) { (status, error) in
            if let error = error {
                print("Authorization status error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            switch status {
            case .unnecessary:
                print("HealthKit authorization is already granted")
            case .shouldRequest:
                print("HealthKit authorization should be requested")
            @unknown default:
                print("Unknown authorization status")
            }
            
            // Detailed authorization request
            self.healthStore.requestAuthorization(toShare: nil, read: [steps]) { (success, authError) in
                guard success else {
                    print("HealthKit authorization failed: \(authError?.localizedDescription ?? "Unknown error")")
                    completion(.failure(authError ?? NSError(domain: "HealthKitError", code: -2,
                                                            userInfo: [NSLocalizedDescriptionKey: "HealthKit authorization failed"])))
                    return
                }
                
                for i in 0...11 {
                    let month = calendar.date(byAdding: .month, value: -i, to: Date()) ?? Date()
                    let (startOfMonth, endOfMonth) = month.fetchMonthStartAndEndDate()
                    
                    // More detailed predicate logging
                    print("Querying steps from \(startOfMonth) to \(endOfMonth)")
                    
                    let predicate = HKQuery.predicateForSamples(withStart: startOfMonth, end: endOfMonth)
                    
                    let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { [weak self] _, results, error in
                        completedQueries += 1
                        
                        // Detailed error and results logging
                        if let error = error {
                            print("Query error for month \(i): \(error.localizedDescription)")
                        }
                        
                        // Check if any results exist
                        if let quantity = results?.sumQuantity() {
                            let stepCount = quantity.doubleValue(for: .count())
                            print("Step count for month \(i): \(stepCount)")
                            
                            if i == 0 {
                                oneYearMonths.append(DailyStepModel(date: month, steps: Int(stepCount)))
                                ytdMonths.append(DailyStepModel(date: month, steps: Int(stepCount)))
                            } else {
                                oneYearMonths.append(DailyStepModel(date: month, steps: Int(stepCount)))
                                if calendar.component(.year, from: Date()) == calendar.component(.year, from: month) {
                                    ytdMonths.append(DailyStepModel(date: month, steps: Int(stepCount)))
                                }
                            }
                        } else {
                            print("No step data available for month \(i)")
                        }
                        
                        // Complete the operation when all queries are done
                        if completedQueries == 12 {
                            if oneYearMonths.isEmpty {
                                completion(.failure(NSError(domain: "HealthKitError", code: -3,
                                                           userInfo: [NSLocalizedDescriptionKey: "No step data found for the entire year"])))
                            } else {
                                completion(.success(YearChartDataResult(ytd: ytdMonths, oneYear: oneYearMonths)))
                            }
                        }
                    }
                    
                    self.healthStore.execute(query)
                }
            }
        }
    }
}
