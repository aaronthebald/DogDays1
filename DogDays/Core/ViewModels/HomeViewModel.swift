//
//  HomeViewModel.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/8/23.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var events: [Event] = []
    @Published var imageName: String = ""
    @Published var nextEvent: Event? = nil
    
    init() {
        let event1 = Event(type: "Groomer", location: "Catwalk", date: Date(), title: "Hair cut", notification: false)
        let event2 = Event(type: "Vet Visit", location: "Millcreek", date: Date(), title: "Dr D", notification: false)
        let event3 = Event(type: "Medication", location: "Chewy.com", date: Date(), title: "Order Meds", notification: false)
        let event4 = Event(type: "Task for Owner", location: "Home", date: Date(), title: "Go for walk", notification: false)
        let event5 = Event(type: "PlayDate", location: "Central bark", date: Date(), title: "Daycare", notification: false)

        events.append(contentsOf: [event1, event2, event3, event4, event5])
    }

    func saveEvent(type: String, location: String, date: Date, title: String, notification: Bool) {
        let newEvent = Event(type: type, location: location, date: date, title: title, notification: notification)
        print(newEvent)
        events.append(newEvent)
        }
    
    func deleteEvent(event: Event) {
        events.removeAll { Event in
            event.id == Event.id
        }
    }
    
    
    // returns string for image based on event.type
    func getImage(event: Event) -> String {
        // if else statement to acheeve same thing as switch (truncated)
        /*
         if event.type == "Groomer" {
        //            return "scissors"
        //        } else if event.type == "Vet Visit" {
        //            return "heart.text.square"
        //        } else if event.type == "Medication" {
        //            return "pills"
        //        } else if event.type == "Task for Owner" {
        //            return "checklist"
        //        } else if event.type == "PlayDate" {
        //            return "pawprint"
        //        }
        //        else {
        //            return  ""
        //        }
         */
        switch event.type {
        case "Groomer":
            return "scissors"
        case "Vet Visit":
            return "heart.text.square"
        case "Medication":
            return "pills"
        case "Task for Owner":
            return "checklist"
        case "PlayDate":
            return "pawprint"
        default:
            return "questionmark.square"
        }
    }
}
