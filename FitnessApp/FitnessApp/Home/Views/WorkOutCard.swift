//
//  WorkOutCard.swift
//  FitnessApp
//
//  Created by Harsh Rajput on 29/01/25.
//

import SwiftUI


struct WorkOutCard: View {
    @State var workout: WorkOut
    var body: some View {
        HStack{
            Image(systemName: workout.image)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundStyle(Color(workout.tintColor))
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color(uiColor: .systemGray4))
                }
           
            VStack(alignment: .leading, spacing: 16){
                
                HStack{
                    Text(workout.title)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .font(.title3)
                        .bold()
                    Spacer()
                    Text(workout.duration)
                }
                HStack{
                    Text(workout.date)
                    Spacer()
                    Text(workout.calories)
                }
            }
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    WorkOutCard(workout: WorkOut(id: 1, title: "Running", image: "figure.run", tintColor: .green, duration: "34 min", date: "Jun 10", calories: "45 Kcal"))
}
