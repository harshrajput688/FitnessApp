//
//  HistoricDataView.swift
//  FitnessApp
//
//  Created by Harsh Rajput on 25/01/25.
//

import SwiftUI
import Charts


struct DailyStepModel: Identifiable{
    let id = UUID()
    let date: Date
    let steps: Double
}

enum ChartOptions: String, CaseIterable{
    case oneweek = "1W"
    case oneMonth = "1M"
    case threeMonth = "3M"
    case yearToDate = "YTD"
    case oneYear = "1Y"
}

class ChartViewModel: ObservableObject{
    var mockChartData = [
        DailyStepModel(date: Date(), steps: 12332),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -1, to:  Date()) ?? Date(), steps: 7332),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -2, to:  Date()) ?? Date(), steps: 10332),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -3, to:  Date()) ?? Date(), steps: 9332),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -4, to:  Date()) ?? Date(), steps: 5332),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -5, to:  Date()) ?? Date(), steps: 13332),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -1, to:  Date()) ?? Date(), steps: 6332)
    ]
}


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
            
            Chart{
                ForEach(viewModel.mockChartData){data in
                    BarMark(x: .value(data.date.formatted(), data.date, unit: .day), y: .value("Steps", data.steps))
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
