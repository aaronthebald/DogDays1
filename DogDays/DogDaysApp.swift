//
//  DogDaysApp.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/8/23.
//

import SwiftUI

@main
struct DogDaysApp: App {

    @StateObject private var vm = HomeViewModel()
    @StateObject private var wvm = WeatherViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
            }
            .environmentObject(vm)
            .environmentObject(wvm)
            
        }
    }
}
