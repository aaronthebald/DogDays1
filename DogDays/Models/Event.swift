//
//  Event.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/8/23.
//

import Foundation

struct Event: Identifiable {
    
    /*
     
     the varibles that go into the event. Can be orginized based on the things within
     location
     time
     title
     type
     isHuman
     */
    
    let type: String
    let location: String
    let date: Date
    let title: String
    let notification: Bool
    var id: String
    
}
