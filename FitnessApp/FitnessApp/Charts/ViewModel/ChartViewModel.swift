//
//  ChartViewModel.swift
//  FitnessApp
//
//  Created by Harsh Rajput on 12/02/25.
//

import Foundation
class ChartViewModel: ObservableObject{
    @Published var oneWeekMockData = [DailyStepModel]()
    @Published var oneMonthMockData = [DailyStepModel]()
    @Published var threeMonthMockData = [DailyStepModel]()
    @Published var yearToDateMockData = [DailyStepModel]()
    @Published var oneYearMockData = [DailyStepModel]()
    
    @Published var average = 1234
    @Published var total = 5123
    init() {
        self.oneWeekMockData = mockDataForDays(Days: 7)
        self.oneMonthMockData = mockDataForDays(Days: 30)
        self.threeMonthMockData = mockDataForDays(Days: 90)
        self.yearToDateMockData = mockDataForDays(Days: 120)
        self.oneYearMockData = mockDataForDays(Days: 365)
    }
    
    func mockDataForDays(Days: Int) -> [DailyStepModel]{
        var mockData : [DailyStepModel] = []
        for day in 0..<Days{
            let date = Calendar.current.date(byAdding: .day, value: -day, to:  Date()) ?? Date()
            let steps: Int = Int.random(in: 5000...10000)
            mockData.append(DailyStepModel(date: date, steps: steps))
        }
        return mockData
    }
    
    func returnTotalSteps(selectedChart: ChartOptions) -> Int{
        switch selectedChart {
        case .oneweek:
            return oneWeekMockData.reduce(0){ $0 + $1.steps }
        case .oneMonth:
            return oneMonthMockData.reduce(0){ $0 + $1.steps }
        case .threeMonth:
            return threeMonthMockData.reduce(0){ $0 + $1.steps }
        case .yearToDate:
            return yearToDateMockData.reduce(0){ $0 + $1.steps }
        case .oneYear:
            return oneYearMockData.reduce(0){ $0 + $1.steps }
        }
    }
    
    func returnAverageSteps(selectedChart: ChartOptions) -> Int{
        switch selectedChart {
        case .oneweek:
            return returnTotalSteps(selectedChart: .oneweek) / oneWeekMockData.count
        case .oneMonth:
            return returnTotalSteps(selectedChart: .oneMonth) / oneMonthMockData.count
        case .threeMonth:
            return returnTotalSteps(selectedChart: .threeMonth) / threeMonthMockData.count
        case .yearToDate:
            return returnTotalSteps(selectedChart: .yearToDate) / yearToDateMockData.count
        case .oneYear:
            return returnTotalSteps(selectedChart: .oneYear) / oneYearMockData.count
        }
    }

}

