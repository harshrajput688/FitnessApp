//
//  HelthManager.swift
//  FitnessApp
//
//  Created by Harsh Rajput on 30/01/25.
//

import Foundation
import HealthKit

extension Date{
    static var startOfDay: Date{
        return Calendar.current.startOfDay(for: Date())
    }
    static var startOfWeek: Date{
        let calendar = Calendar.current
        var component = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        component.weekday = 2
        return calendar.date(from: component) ?? Date()
    }
}

extension Double{
    func formattedNumberString() -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: self)) ?? "0"
    }
}

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
                completion(.failure(NSError()))
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
}

