//
//  HomeView.swift
//  FitnessApp
//
//  Created by Harsh Rajput on 25/01/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
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
                                
                                Text("\(viewModel.calories) Kcal")
                                    .bold()
                            }
                            .padding(.bottom)
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Active")
                                    .font(.callout)
                                    .bold()
                                    .foregroundStyle(.green)
                                
                                Text("\(viewModel.exercise) mins")
                                    .bold()
                            }
                            .padding(.bottom)
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Stand")
                                    .font(.callout)
                                    .bold()
                                    .foregroundStyle(.blue)
                                
                                Text("\(viewModel.stand) hours")
                                    .bold()
                            }
                        }
                        Spacer()
                        ZStack{
                            ProgressCircleView(progress: $viewModel.calories, goal: 600, color: .red)
                            ProgressCircleView(progress: $viewModel.exercise, goal: 60, color: .green)
                                .padding(20)
                            ProgressCircleView(progress: $viewModel.stand, goal: 12, color: .blue)
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
                    if !viewModel.activities.isEmpty{
                        LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                            ForEach(viewModel.activities, id: \.title){ activity in
                                ActivityCard(activity: activity)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    HStack{
                        Text("Recent Activity")
                            .font(.title2)
                        Spacer()
                        
                        NavigationLink {
                            EmptyView()
                        } label: {
                            Text("Show More")
                                .padding(10)
                                .foregroundStyle(.white)
                                .background(.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        
                        
                    }
                    .padding(.horizontal)
                    LazyVStack{
                        ForEach(viewModel.mockWorkOuts, id: \.id) { workout in
                            WorkOutCard(workout: workout)
                        }
                    }
                    .padding(.bottom)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

