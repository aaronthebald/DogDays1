//
//  DogDaysApp.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/8/23.
//

import SwiftUI

@main



struct DogDaysApp: App {
    
    
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView(vm: HomeViewModel())
            }
            
        }
    }
}
