//
//  HomeViewModel.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/8/23.
//

import Foundation
import SwiftUI
import Combine
import CoreData

class HomeViewModel: ObservableObject {
    
    @Published var events: [EventEntity] = []
    @Published var imageName: String = ""
    @Published var nextEvent: Event? = nil
    @Published var animate: Bool = false
    
//    private let eventsDataService = EventsDataService()
    private var cancellables = Set<AnyCancellable>()
    
    private let container: NSPersistentContainer
    private let containerName: String = "EventContainer"
    private let entityName: String = "EventEntity"
    
    init() {
//        let event1 = Event(type: "Groomer", location: "Catwalk", date: Date(), title: "Hair cut", notification: false, id: UUID().uuidString)
//        let event2 = Event(type: "Vet Visit", location: "Millcreek", date: Date(), title: "Dr D", notification: false, id: UUID().uuidString)
//        let event3 = Event(type: "Medication", location: "Chewy.com", date: Date(), title: "Order Meds", notification: false, id: UUID().uuidString)
//        let event4 = Event(type: "Task for Owner", location: "Home", date: Date(), title: "Go for walk", notification: false, id: UUID().uuidString)
//        let event5 = Event(type: "PlayDate", location: "Central bark", date: Date(), title: "Daycare", notification: false, id: UUID().uuidString)
        
      //  events.append(contentsOf: [event1, event2, event3, event4, event5])
        container = NSPersistentContainer(name: containerName)
            container.loadPersistentStores { _, error in
                if let error = error {
                    print("Error loading coredata \(error)")
                }
                self.getEvents()
            }
//        events.append(contentsOf: [ event1, event2, event3, event4, event5])
    }
    
//    func setUp() {
//        eventsDataService.$savedEntities
//            .map(mapEntityToEvent)
//            .sink { [weak self] mappedEntities in
//                self?.events = mappedEntities
//            }
//            .store(in: &cancellables)
//
//    }
    
    
    private func getEvents() {
        let request = NSFetchRequest<EventEntity>(entityName: entityName)
        do {
          events = try container.viewContext.fetch(request)
        } catch let error {
            print("Error catching portfolio entities \(error)")
        }
    }
    // old func
//    func saveEvent(type: String, location: String, date: Date, title: String, notification: Bool) {
//        let newEvent = Event(type: type, location: location, date: date, title: title, notification: notification, id: UUID().uuidString)
//        print(newEvent)
//        events.append(newEvent)
//        eventsDataService.updateEvents(event: newEvent)
//    }
    // old func
//    func deleteEvent(event: EventEntity) {
//        events.removeAll { Event in
//            event.id == Event.id
//        }
//    }
    // old func
//    func updateEvent(event: EventEntity) {
//        if let index = events.firstIndex(where: { $0.id == event.id }) {
//            events.remove(at: index)
//
//           applyChanges()
//        }
//    }
    func updateEvent(event: EventEntity) {
       // print(event)
        if let entity = events.first(where: {$0.id == event.id}) {
            entity.title = event.title
            entity.location = event.location
            entity.type = event.type
            entity.date = event.date
            entity.notification = event.notification
            entity.id = event.id
            applyChanges()
        }
        print("Vm connected")
    }

//    func updateEvent(event: EventEntity) {
//        print(event)
//        let entity = EventEntity(context: container.viewContext)
//        entity.title = event.title
//        entity.location = event.location
//        entity.type = event.type
//        entity.date = event.date
//        entity.notification = event.notification
//        entity.id = event.id
//        print(entity)
//        applyChanges()
//        print("Vm connected")
//    }
    
     func add(event: Event) {
        let entity = EventEntity(context: container.viewContext)
        entity.title = event.title
        entity.location = event.location
        entity.type = event.type
        entity.date = event.date
        entity.notification = event.notification
        entity.id = event.id
        applyChanges()
         print("Vm func ran")
    }

     func delete(entity: EventEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
        
     func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to CoreData \(error)")
        }
    }
    
     func applyChanges() {
        save()
        getEvents()
    }
//    func mapEntityToEvent(entity: [EventEntity]){
//        ForEach(entity, id: \.self) { entity in
//            let event: Event = {
//                event.title = entity.title
//                event.location = entity.location
//                event.date.description = entity.date
//                event.notification = entity.notification
//                event.id = entity.id
//            }()
//
//            events.append(event)
//
//        }
//
//
//    }
    
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
    func getImage(event: EventEntity) -> String {
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
