//
//  FitnessTabView.swift
//  FitnessApp
//
//  Created by Harsh Rajput on 25/01/25.
//

import SwiftUI

struct FitnessTabView: View {
    @State var selectedTab = "Home"
    
    init(){
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.stackedLayoutAppearance.selected.iconColor = .green
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.green]
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $selectedTab, content: {
            HomeView()
                .tag("Home")
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            HistoricDataView()
                .tag("Historic")
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Charts")
                }
        })
    }
}

#Preview {
    FitnessTabView()
}
