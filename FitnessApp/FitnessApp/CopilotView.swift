//
//  CopilotView.swift
//  FitnessApp
//
//  Created by Harsh Rajput on 26/01/25.
//


import SwiftUI

struct ContentView1: View {
    var body: some View {
        VStack {
            Text("Welcome")
                .font(.largeTitle)
                .padding(.top, 50)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Calories")
                        .foregroundColor(.red)
                    Text("123 kcal")
                        .font(.title)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Active")
                        .foregroundColor(.green)
                    Text("52 min")
                        .font(.title)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Stand")
                        .foregroundColor(.blue)
                    Text("8 hours")
                        .font(.title)
                }
            }
            .padding(.horizontal)
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(.red)
                Circle()
                    .trim(from: 0.0, to: 0.3)
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.red)
                    .rotationEffect(Angle(degrees: -90))
                
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(.green)
                Circle()
                    .trim(from: 0.0, to: 0.52)
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.green)
                    .rotationEffect(Angle(degrees: -90))
                
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(.blue)
                Circle()
                    .trim(from: 0.0, to: 0.8)
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.blue)
                    .rotationEffect(Angle(degrees: -90))
            }
            .frame(width: 200, height: 200)
            .padding()
            
            Text("Fitness Activity")
                .font(.title2)
                .padding(.top)
            
            HStack {
                VStack {
                    Text("Today steps")
                    Text("Goal 12,000")
                        .font(.caption)
                    Text("6000")
                        .font(.largeTitle)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                
                VStack {
                    Text("Today")
                    Text("Goal 1,000")
                        .font(.caption)
                    Text("812")
                        .font(.largeTitle)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }
            .padding(.horizontal)
            
            HStack {
                VStack {
                    Text("Today steps")
                    Text("Goal 12,000")
                        .font(.caption)
                    Text("15000")
                        .font(.largeTitle)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                
                VStack {
                    Text("Today steps")
                    Text("Goal 12,000")
                        .font(.caption)
                    Text("6000")
                        .font(.largeTitle)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Button(action: {
                // Action for Show More button
            }) {
                Text("Show More")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView1()
    }
}

