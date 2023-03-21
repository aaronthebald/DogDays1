//
//  EventsDataService.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/21/23.
//

import Foundation
import CoreData

class EventsDataService {
    private let container: NSPersistentContainer
    private let containerName: String = "EventData"
    private let entityName: String = "EventEntity"
    
    @Published var savedEntities: [EventEntity] = []
    
    init() {
    container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading coredata \(error)")
            }
            self.getEvents()
        }
    }
    
    func updateEvents(event: Event) {

        // checks if coin is already in portfolio
        if let entity = savedEntities.first(where: { $0.id == event.id }) {

            if entity.title != event.title {
                update(entity: entity, event: event)
            } else {
                delete(entity: entity)
            }
        } else {
            add(event: event)
        }
    }
    
    private func getEvents() {
        let request = NSFetchRequest<EventEntity>(entityName: entityName)
        do {
          savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error catching portfolio entities \(error)")
        }
    }
    
    private func add(event: Event) {
        let entity = EventEntity(context: container.viewContext)
        entity.title = event.title
        entity.location = event.location
        entity.type = event.type
        entity.date = event.date.description
        entity.notification = event.notification
        entity.id = event.id
        applyChanges()
    }
    
    private func update(entity: EventEntity, event: Event) {
        entity.title = event.title
        entity.location = event.location
        entity.type = event.type
        entity.date = event.date.description
        entity.notification = event.notification
        entity.id = event.id
        applyChanges()
    }
    
    private func delete(entity: EventEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to CoreData \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getEvents()
    }

}
