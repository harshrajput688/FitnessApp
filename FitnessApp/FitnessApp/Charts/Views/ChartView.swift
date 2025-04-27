//
//  HistoricDataView.swift
//  FitnessApp
//
//  Created by Harsh Rajput on 25/01/25.
//

import SwiftUI
import Charts

struct ChartView: View {
    @StateObject var viewModel: ChartViewModel = ChartViewModel()
    @State var selectedChart: ChartOptions = .oneweek
    var body: some View {
        VStack{
            Text("Charts")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            
            
            ZStack{
                switch selectedChart {
                case .oneweek:
                    VStack{
                        StepCountViewAvgAndTotal(avg: 0, total: 0)
                        Chart{
                            ForEach(viewModel.oneWeekMockData){data in
                                BarMark(x: .value(data.date.formatted(), data.date, unit: .day), y: .value("Steps", data.steps))
                            }
                        }
                    }
                    
                case .oneMonth:
                    VStack{
                        StepCountViewAvgAndTotal(avg: 0, total: 0)
                        Chart{
                            ForEach(viewModel.oneMonthMockData){data in
                                BarMark(x: .value(data.date.formatted(), data.date, unit: .day), y: .value("Steps", data.steps))
                            }
                        }
                    }
                case .threeMonth:
                    VStack{
                        StepCountViewAvgAndTotal(avg: 0, total: 0)
                        Chart{
                            ForEach(viewModel.threeMonthMockData){data in
                                BarMark(x: .value(data.date.formatted(), data.date, unit: .month), y: .value("Steps", data.steps))
                            }
                        }
                    }
                case .yearToDate:
                    VStack{
                        StepCountViewAvgAndTotal(avg: viewModel.ytdAverage, total: viewModel.ytdTotal)
                        Chart{
                            ForEach(viewModel.yearToDateMockData){data in
                                BarMark(x: .value(data.date.formatted(), data.date, unit: .month), y: .value("Steps", data.steps))
                            }
                        }
                    }
                case .oneYear:
                    VStack{
                        StepCountViewAvgAndTotal(avg: viewModel.oneYearAverage, total: viewModel.oneYearAverage)
                        Chart{
                            ForEach(viewModel.oneYearMockData){data in
                                BarMark(x: .value(data.date.formatted(), data.date, unit: .month), y: .value("Steps", data.steps))
                            }
                        }
                    }
                }
                
                
            }
            .foregroundStyle(.green)
            .frame(maxHeight: 350)
            .padding(.horizontal)
            
            HStack{
                ForEach(ChartOptions.allCases, id: \.rawValue){ option in
                    Button(option.rawValue){
                        print(option)
                        withAnimation {
                            selectedChart = option
                        }
                    }
                    .padding()
                    .foregroundStyle(option == selectedChart ? .white :  .green)
                    .background(option == selectedChart ? .green :  .white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    ChartView()
}
