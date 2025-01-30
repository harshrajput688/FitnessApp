//
//  ActivityCard.swift
//  FitnessApp
//
//  Created by Harsh Rajput on 26/01/25.
//

import SwiftUI

struct ActivityCard: View {
    @State var activity: Acitvity
    var body: some View {
        ZStack{
            Color(uiColor: .systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack{
                HStack(alignment: .top){
                    VStack(alignment: .leading, spacing: 8){
                        Text(activity.title)
                        Text(activity.subTitle)
                            .font(.caption)
                            .foregroundStyle(Color(uiColor: .systemGray))
                        
                    }
                    Spacer()
                    Image(systemName: activity.image)
                        .foregroundStyle(activity.tintColor)
                }
                Text(activity.amount)
                    .font(.title)
                    .bold()
                    .padding()
            }
            .padding()
        }
    }
}

#Preview {
    ActivityCard(activity: Acitvity(id: 1, title: "Today steps", subTitle: "Goal 12,000", image: "figure.walk", tintColor: .green, amount: "6000"))
}
