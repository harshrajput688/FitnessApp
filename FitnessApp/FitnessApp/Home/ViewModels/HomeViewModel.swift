//
//  HomeViewModel.swift
//  FitnessApp
//
//  Created by Harsh Rajput on 30/01/25.
//

import Foundation
class HomeViewModel: ObservableObject{
    var calories: Int = 123
    var active: Int = 52
    var stand: Int = 8
    @Published var mockActivities: [Acitvity] = [Acitvity(id: 0, title: "Today steps", subTitle: "Goal 12,000", image: "figure.walk", tintColor: .green, amount: "6000"),
                                      Acitvity(id: 1, title: "Today", subTitle: "Goal 1,000", image: "figure.walk", tintColor: .red, amount: "812"),
                                      Acitvity(id: 2, title: "Today steps", subTitle: "Goal 12,000", image: "figure.run", tintColor: .blue, amount: "15000"),
                                      Acitvity(id: 3, title: "Today steps", subTitle: "Goal 12,000", image: "figure.walk", tintColor: .orange, amount: "6000")
    ]
    
    @Published var mockWorkOuts: [WorkOut] = [WorkOut(id: 0, title: "Running", image: "figure.run", tintColor: .orange, duration: "34 min", date: "Jun 10", calories: "45 Kcal"),
                               WorkOut(id: 1, title: "Running", image: "figure.run", tintColor: .green, duration: "34 min", date: "Jun 10", calories: "45 Kcal"),
                               WorkOut(id: 2, title: "Running", image: "figure.run", tintColor: .red, duration: "34 min", date: "Jun 10", calories: "45 Kcal"),
                                   WorkOut(id: 3, title: "Running", image: "figure.run", tintColor: .yellow, duration: "34 min", date: "Jun 10", calories: "45 Kcal")
        
    ]
    
}
