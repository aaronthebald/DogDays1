//
//  ContactViewModel.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/14/23.
//

import Foundation
import CoreData

class ContactViewModel: ObservableObject {
    
    @Published var contacts: [ContactEntity] = []
    
    private let container: NSPersistentContainer
    private let containerName: String = "ContactContainer"
    private let entityName: String = "ContactEntity"
    
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading CoreData \(error)")
            }
            self.getContacts()
        }
        
    }
    
    private func getContacts() {
        let request = NSFetchRequest<ContactEntity>(entityName: entityName)
        do {
            contacts = try container.viewContext.fetch(request)
        } catch let error {
            print("Error catching from CoreData \(error)")
        }
    }
    
    func saveContact(name: String, phone: String, category: String, id: String) {
        
        let newContact = ContactModel(name: name, phone: phone, category: category, id: id)
        let entity = ContactEntity(context: container.viewContext)
            entity.name = newContact.name
//            entity.address = newContact.address
            entity.phone = newContact.phone
            entity.category = newContact.category
            entity.id = newContact.id
            applyChanges()
        
    }
   
    func deleteContact(deletedEntity: ContactEntity) {
        container.viewContext.delete(deletedEntity)
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
        getContacts()
    }
}
