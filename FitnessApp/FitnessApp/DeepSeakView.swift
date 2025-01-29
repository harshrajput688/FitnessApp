//
//  DeepSeakView.swift
//  FitnessApp
//
//  Created by Harsh Rajput on 29/01/25.
//

import SwiftUI

//struct DeepSeakView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    DeepSeakView()
//}
import SwiftUI

struct ContentView2: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Welcome")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Calories")
                        .font(.headline)
                    Text("123 kcal")
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Active")
                        .font(.headline)
                    Text("52min")
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Stand")
                        .font(.headline)
                    Text("8 hours")
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
            
            Button(action: {
                // Action for Fitness Activity
            }) {
                Text("Fitness Activity")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Today steps")
                    .font(.headline)
                
                HStack {
                    Text("Today")
                    Spacer()
                    Text("Goal 12,000")
                }
                
                ProgressView(value: 6000, total: 12000)
                    .accentColor(.blue)
                
                HStack {
                    Text("6,000")
                    Spacer()
                    Text("12,000")
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
#Preview {
    ContentView2()
}
