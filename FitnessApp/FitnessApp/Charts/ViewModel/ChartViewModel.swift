//
//  ChartViewModel.swift
//  FitnessApp
//
//  Created by Harsh Rajput on 12/02/25.
//

import Foundation
class ChartViewModel: ObservableObject{
    
    let healthManager = HealthManager.shared
    
    @Published var oneWeekMockData = [DailyStepModel]()
    @Published var oneMonthMockData = [DailyStepModel]()
    @Published var threeMonthMockData = [DailyStepModel]()
    
    
    
    @Published var ytdAverage = 0
    @Published var ytdTotal = 0
    @Published var yearToDateMockData = [DailyStepModel]()
    
    @Published var oneYearAverage = 0
    @Published var oneYearTotal = 0
    @Published var oneYearMockData = [DailyStepModel]()
    
    init() {
        self.oneWeekMockData = mockDataForDays(Days: 7)
        self.oneMonthMockData = mockDataForDays(Days: 30)
        self.threeMonthMockData = mockDataForDays(Days: 90)
        fetchYTDAndOneYearChartDate()
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
        let totalSteps = returnTotalSteps(selectedChart: selectedChart)
        let count: Int
        
        switch selectedChart {
        case .oneweek:
            count = oneWeekMockData.count
        case .oneMonth:
            count = oneMonthMockData.count
        case .threeMonth:
            count = threeMonthMockData.count
        case .yearToDate:
            count = yearToDateMockData.count
        case .oneYear:
            count = oneYearMockData.count
        }
        
        return count > 0 ? totalSteps / count : 0  // Prevent division by zero
    }

    
    func fetchYTDAndOneYearChartDate(){
        healthManager.fetchYTDAndOneYearChartData { result in
            switch result {
                case .success(let data):
                DispatchQueue.main.async {
                    self.yearToDateMockData = data.ytd
                    self.oneYearMockData = data.oneYear
                    
                    self.ytdTotal = self.yearToDateMockData.reduce(0, { $0 + $1.steps })
                    self.ytdAverage = self.ytdTotal / Calendar.current.component(.month, from: Date())
                    
                    self.oneYearTotal = self.oneYearMockData.reduce(0, { $0 + $1.steps })
                    self.oneYearAverage = self.oneYearTotal / 12
                    
                    print("ytdAverage: \(self.ytdAverage)")
                    print("oneYearAverage: \(self.oneYearAverage)")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

