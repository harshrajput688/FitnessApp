//
//  DailyStepModel.swift
//  FitnessApp
//
//  Created by Harsh Rajput on 12/02/25.
//

import Foundation

struct DailyStepModel: Identifiable{
    let id = UUID()
    let date: Date
    let steps: Int
}
