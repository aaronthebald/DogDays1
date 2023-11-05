//
//  MainView.swift
//  DogDays
//
//  Created by Aaron Wilson on 11/4/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Future Events", systemImage: "house.fill")
                }
            
        }
    }
}

#Preview {
    MainView()
}
