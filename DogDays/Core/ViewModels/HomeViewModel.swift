//
//  HomeViewModel.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/8/23.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var events: [Event] = []
    @Published var imageName: String = ""
    @Published var nextEvent: Event? = nil
    @Published var animate: Bool = false
    
    private let eventsDataService = EventsDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        let event1 = Event(type: "Groomer", location: "Catwalk", date: Date(), title: "Hair cut", notification: false, id: UUID().uuidString)
        let event2 = Event(type: "Vet Visit", location: "Millcreek", date: Date(), title: "Dr D", notification: false, id: UUID().uuidString)
        let event3 = Event(type: "Medication", location: "Chewy.com", date: Date(), title: "Order Meds", notification: false, id: UUID().uuidString)
        let event4 = Event(type: "Task for Owner", location: "Home", date: Date(), title: "Go for walk", notification: false, id: UUID().uuidString)
        let event5 = Event(type: "PlayDate", location: "Central bark", date: Date(), title: "Daycare", notification: false, id: UUID().uuidString)
        
        events.append(contentsOf: [event1, event2, event3, event4, event5])
        
    }
    
    func setUp() {
        eventsDataService.$savedEntities
            .map(mapEntityToEvent)
            .sink { [weak self] mappedEntities in
                self?.events = mappedEntities
            }
            .store(in: &cancellables)
                                
    }
    
    
    func saveEvent(type: String, location: String, date: Date, title: String, notification: Bool) {
        let newEvent = Event(type: type, location: location, date: date, title: title, notification: notification, id: UUID().uuidString)
        print(newEvent)
        events.append(newEvent)
        eventsDataService.updateEvents(event: newEvent)
    }
    
    func deleteEvent(event: Event) {
        events.removeAll { Event in
            event.id == Event.id
        }
        
    }
    
    func updateEvent(event: Event) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events.remove(at: index)
            events.append(event)
        }
    }
    
   
    func mapEntityToEvent(entity: [EventEntity]){
        ForEach(entity, id: \.self) { entity in
            let event: Event = {
                event.title = entity.title
                event.location = entity.location
                event.date.description = entity.date
                event.notification = entity.notification
                event.id = entity.id
            }()
            
            events.append(event)
            
        }
            
       
    }
    
//    func mapEntityToEvent(entity: [EventEntity]) {
//        ForEach(entity, id: \.self) { entity in
//            let event: Event = {
//                entity.title = event.title
//                entity.location = event.location
//                entity.date = event.date.description
//                entity.notification = event.notification
//                entity.id = event.id
//            }()
//
//            events.append(event)
//
//        }
//
//
//    }
    
    
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
