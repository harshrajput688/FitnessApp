//
//  StepCountViewAvgAndTotal.swift
//  FitnessApp
//
//  Created by Harsh Rajput on 14/02/25.
//

import SwiftUI

struct StepCountViewAvgAndTotal: View {
    @State var avg: Int
    @State var total: Int
    var body: some View {
        HStack{
            Spacer()
            VStack(spacing: 10){
                Text("Average")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.black)
                Text("\(avg)")
                    .font(.title3)
                    .foregroundStyle(.black)
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
                    .foregroundStyle(.black)
                Text("\(total)")
                    .font(.title3)
                    .foregroundStyle(.black)
            }
            .frame(maxWidth: 100)
            .padding()
            .background{
                Color.gray.opacity(0.1)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Spacer()
        }
    }
}


#Preview {
    StepCountViewAvgAndTotal(avg: 4567, total: 57667)
}
