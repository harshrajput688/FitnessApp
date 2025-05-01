//
//  PaywallView.swift
//  FitnessApp
//
//  Created by Harsh Rajput on 27/04/25.
//

import SwiftUI

struct PaywallView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 16){
            Text("Preminum Membership")
                .font(.largeTitle)
                .bold()
            Text("Get fit, get active today")
            
            Spacer()
            
            //Fetures
            VStack(spacing: 20){
                HStack{
                    Image(systemName: "figure.run")
                    Text("Exersize boosts your energy levels and promotes vitaility")
                        .lineLimit(1)
                        .font(.system(size: 14))
                }
                
                HStack{
                    Image(systemName: "figure.run")
                    Text("Exersize boosts your energy levels and promotes vitaility")
                        .lineLimit(1)
                        .font(.system(size: 14))
                }
                
                HStack{
                    Image(systemName: "figure.run")
                    Text("Exersize boosts your energy levels and promotes vitaility")
                        .lineLimit(1)
                        .font(.system(size: 14))
                }
            }
            .padding(.vertical)
            
            Spacer()
            
            HStack{
                Button {
                    
                } label: {
                    Text("Monthly $99")
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .frame(height: 100)
                .background{
                    RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 2)
                        .foregroundStyle(.green)
                }
                
                Button {
                    
                } label: {
                    Text("Annualy $99")
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .frame(height: 100)
                .background{
                    RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 2)
                        .foregroundStyle(.green)
                }
            }
            .padding(.horizontal, 40)
            Button {
                
            } label: {
                Text("Restore Perchase")
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.green)
                    .underline()
            }
            Spacer()
            
            HStack{
                Link("Terms of use", destination: URL(string: "https://www.youtube.com/")!)
                Link("Privacy Policy", destination: URL(string: "https://www.youtube.com/")!)
            }

        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    PaywallView()
}
