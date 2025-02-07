//
//  HomeViewModel.swift
//  FitnessApp
//
//  Created by Harsh Rajput on 30/01/25.
//

import Foundation
class HomeViewModel: ObservableObject{
    
    let healthManager = HealthManager.shared
    
    @Published var calories: Int = 0
    @Published var exercise: Int = 0
    @Published var stand: Int = 0
    @Published var activities: [Acitvity] = []
    @Published var mockActivities: [Acitvity] = [Acitvity(title: "Today steps", subTitle: "Goal 12,000", image: "figure.walk", tintColor: .green, amount: "6000"),
                                                 Acitvity(title: "Today", subTitle: "Goal 1,000", image: "figure.walk", tintColor: .red, amount: "812"),
                                                 Acitvity(title: "Today steps", subTitle: "Goal 12,000", image: "figure.run", tintColor: .blue, amount: "15000"),
                                                 Acitvity(title: "Today steps", subTitle: "Goal 12,000", image: "figure.walk", tintColor: .orange, amount: "6000")
    ]
    
    @Published var mockWorkOuts: [WorkOut] = [WorkOut(id: 0, title: "Running", image: "figure.run", tintColor: .orange, duration: "34 min", date: "Jun 10", calories: "45 Kcal"),
                                              WorkOut(id: 1, title: "Running", image: "figure.run", tintColor: .green, duration: "34 min", date: "Jun 10", calories: "45 Kcal"),
                                              WorkOut(id: 2, title: "Running", image: "figure.run", tintColor: .red, duration: "34 min", date: "Jun 10", calories: "45 Kcal"),
                                              WorkOut(id: 3, title: "Running", image: "figure.run", tintColor: .yellow, duration: "34 min", date: "Jun 10", calories: "45 Kcal")
                                              
    ]
    
    init(){
        
        Task{
            do{
                try await healthManager.requestHeathKitAccess()
                fetchTodayCalories()
                fetchTodayExerciseTime()
                fetchTodayStandHours()
                fetchTodaysSteps()
                fetchCurrentWeekActivies()
            }catch{
                print(error.localizedDescription)
            }
            
        }
    }
    
    func fetchTodayCalories(){
        healthManager.fetchTodayCaloriesBurned { result in
            switch result{
            case .success(let calories):
                DispatchQueue.main.async{
                    print(calories)
                    self.calories = Int(calories)
                    let activity = Acitvity(title: "Calories Burned", subTitle: "Today", image: "flame", tintColor: .green, amount: calories.formattedNumberString())
                    self.activities.append(activity)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
        
    func fetchTodayExerciseTime(){
        healthManager.fetchTodayExerciseTime { result in
            switch result{
            case .success(let exercise):
                DispatchQueue.main.async {
                    print(exercise)
                    self.exercise = Int(exercise)
                }
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
        
    func fetchTodayStandHours(){
        healthManager.fetchTodayStandHours { result in
            switch result{
            case .success(let hours):
                DispatchQueue.main.async{
                    print(hours)
                    self.stand = hours
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            
        }
        
    }
    
    func fetchTodaysSteps(){
        healthManager.fetchTodaySteps{ result in
            switch result{
            case .success(let activity):
                DispatchQueue.main.async{
                    print(activity)
                    self.activities.append(activity)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchCurrentWeekActivies(){
        healthManager.fetchCurrentWeekWorkoutState { result in
            switch result {
            case .success(let activities):
                DispatchQueue.main.async{
                    self.activities.append(contentsOf: activities)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
