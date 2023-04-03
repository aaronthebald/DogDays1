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
    @Published var sortedEvents: [EventEntity] = []
    
    
    private let container: NSPersistentContainer
    private let containerName: String = "EventContainer"
    private let entityName: String = "EventEntity"
    
    init() {
        container = NSPersistentContainer(name: containerName)
            container.loadPersistentStores { _, error in
                if let error = error {
                    print("Error loading coredata \(error)")
                }
                self.getEvents()
            }
        sortEvents()
        print("HomeVM ran")
    }
    

    
    
    private func getEvents() {
        let request = NSFetchRequest<EventEntity>(entityName: entityName)
        do {
          events = try container.viewContext.fetch(request)
        } catch let error {
            print("Error catching portfolio entities \(error)")
        }
    }

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
    
    func sortEvents() {
            events = events.sorted(by: {$0.date?.timeIntervalSinceNow ?? .zero < $1.date?.timeIntervalSinceNow ?? .zero})
            
    }
    
}
