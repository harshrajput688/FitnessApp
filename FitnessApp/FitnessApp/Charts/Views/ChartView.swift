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
            
            HStack{
                Spacer()
                VStack(spacing: 10){
                    Text("Average")
                        .font(.title2)
                        .bold()
                    Text("\(viewModel.returnAverageSteps(selectedChart: selectedChart))")
                        .font(.title3)
                }
                .frame(maxWidth: 100)
                .padding()
                .background{
                    Color.gray.opacity(0.1)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Spacer()
                VStack(spacing: 10){
                    Text("Total")
                        .font(.title2)
                        .bold()
                    Text("\(viewModel.returnTotalSteps(selectedChart: selectedChart))")
                        .font(.title3)
                }
                .frame(maxWidth: 100)
                .padding()
                .background{
                    Color.gray.opacity(0.1)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                Spacer()
            }
            
            ZStack{
                switch selectedChart {
                case .oneweek:
                    Chart{
                        ForEach(viewModel.oneWeekMockData){data in
                            BarMark(x: .value(data.date.formatted(), data.date, unit: .day), y: .value("Steps", data.steps))
                        }
                    }
                case .oneMonth:
                    Chart{
                        ForEach(viewModel.oneMonthMockData){data in
                            BarMark(x: .value(data.date.formatted(), data.date, unit: .day), y: .value("Steps", data.steps))
                        }
                    }
                case .threeMonth:
                    Chart{
                        ForEach(viewModel.threeMonthMockData){data in
                            BarMark(x: .value(data.date.formatted(), data.date, unit: .month), y: .value("Steps", data.steps))
                        }
                    }
                case .yearToDate:
                    Chart{
                        ForEach(viewModel.yearToDateMockData){data in
                            BarMark(x: .value(data.date.formatted(), data.date, unit: .month), y: .value("Steps", data.steps))
                        }
                    }
                case .oneYear:
                    Chart{
                        ForEach(viewModel.oneYearMockData){data in
                            BarMark(x: .value(data.date.formatted(), data.date, unit: .month), y: .value("Steps", data.steps))
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
