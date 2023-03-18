//
//  ContactViewModel.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/14/23.
//

import Foundation

class ContactViewModel: ObservableObject {
    
    @Published var Contacts: [ContactModel] = []
    
    init() {
        let testContact1 = ContactModel(name: "Aaron", address: "1030 Chapel Road", phone: "803-422-0348", category: "Owner", id: UUID().uuidString)
        
        Contacts.append(testContact1)
    }
    
    func saveContact(name: String, address: String, phone: String, category: String, id: String) {
        
        let newContact = ContactModel(name: name, address: address, phone: phone, category: category, id: id)
        
        Contacts.append(newContact)
    }
   
    func deleteContact(indexSet: IndexSet) {
        Contacts.remove(atOffsets: indexSet)
    }
    
}
