//
//  Event.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/8/23.
//

import Foundation

struct Event: Identifiable {
    
    let type: String
    let location: String
    let date: Date
    let title: String
    let notification: Bool
    var id: String
    
}
