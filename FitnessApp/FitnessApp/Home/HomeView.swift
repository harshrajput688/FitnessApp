//
//  HomeView.swift
//  FitnessApp
//
//  Created by Harsh Rajput on 25/01/25.
//

import SwiftUI

struct HomeView: View {
    @State var calories: Int = 123
    @State var active: Int = 52
    @State var stand: Int = 8
    
    var mockActivities: [Acitvity] = [Acitvity(id: 0, title: "Today steps", subTitle: "Goal 12,000", image: "figure.walk", tintColor: .green, amount: "6000"),
                                      Acitvity(id: 1, title: "Today", subTitle: "Goal 1,000", image: "figure.walk", tintColor: .red, amount: "812"),
                                      Acitvity(id: 2, title: "Today steps", subTitle: "Goal 12,000", image: "figure.run", tintColor: .blue, amount: "15000"),
                                      Acitvity(id: 3, title: "Today steps", subTitle: "Goal 12,000", image: "figure.walk", tintColor: .orange, amount: "6000")]
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(alignment: .leading){
                Text("Welcome")
                    .font(.largeTitle)
                    .padding()
                
                HStack{
                    Spacer()
                    VStack(alignment: .leading){
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Calories")
                                .font(.callout)
                                .bold()
                                .foregroundStyle(.red)
                                
                            Text("123 kcal")
                                .bold()
                        }
                        .padding(.bottom)
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Active")
                                .font(.callout)
                                .bold()
                                .foregroundStyle(.green)
                                
                            Text("52 min")
                                .bold()
                        }
                        .padding(.bottom)
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Stand")
                                .font(.callout)
                                .bold()
                                .foregroundStyle(.blue)
                                
                            Text("8 hours")
                                .bold()
                        }
                    }
                    Spacer()
                    ZStack{
                        ProgressCircleView(progress: $calories, goal: 600, color: .red)
                        ProgressCircleView(progress: $active, goal: 60, color: .green)
                            .padding(20)
                        ProgressCircleView(progress: $stand, goal: 12, color: .blue)
                            .padding(40)
                    }
                    .padding(.horizontal)
                    Spacer()
                }
                .padding(.horizontal)
                HStack{
                    Text("Fitness Activity")
                        .font(.title2)
                    Spacer()
                    
                    Button {
                        print("Show More")
                    } label: {
                        Text("Show More")
                            .padding(10)
                            .foregroundStyle(.white)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }

                }
                .padding(.horizontal)
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                    ForEach(mockActivities){ activity in
                            ActivityCard(activity: activity)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    HomeView()
}

