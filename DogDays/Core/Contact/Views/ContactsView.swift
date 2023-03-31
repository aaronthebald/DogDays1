//
//  ContactsView.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/14/23.
//

import SwiftUI

struct ContactsView: View {
    
    @StateObject private var vm: ContactViewModel = ContactViewModel()
    
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State var showAddContactView: Bool = false
    @State private var selectedContact: ContactEntity? = nil
    @Binding var showContactSheet: Bool
    
    
    var body: some View {
        NavigationStack() {
            List {
                contactCard
            }
            .navigationTitle("Contacts")

            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showContactSheet.toggle()
                    } label: {
                        Image(systemName: "chevron.down")
                    }

                }
                
                ToolbarItem(placement:.navigationBarTrailing) {
                    Button {
                        showAddContactView.toggle()
                    } label: {
                        Image(systemName: showAddContactView ? "xmark" : "plus")
                    }
        }
      }
    }
        .alert(alertTitle, isPresented: $showAlert, actions: {
            if let selectedContact = selectedContact {
                HStack {
                    Button {
                        showAlert = false
                    } label: {
                        Text("Dismiss")
                    }
                    Button {
                        vm.deleteContact(deletedEntity: selectedContact)
                    } label: {
                        Text("DELETE")
                    }
                }
            }
        }
        )
        .sheet(isPresented: $showAddContactView) {
            AddContactView(vm: vm, showAddContactView: $showAddContactView)
                .presentationDetents([.medium]).presentationDragIndicator(.visible)
        }
  }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView( showContactSheet: .constant(false))
    }
}

extension ContactsView {
    
    private var contactCard: some View {
        ForEach(vm.contacts) { contact in
            VStack(spacing: 5) {
                HStack {
                    Text("Name:")
                    Spacer()
                    Text(contact.name ?? "Failed to load Contact")
                }
                Divider()
                HStack {
                    Text("Category:")
                    Spacer()
                    Text(contact.category ?? "Failed to load Contact")
                }
                
                if ((contact.address?.isEmpty) != nil) {
                    EmptyView()
                } else {
                    Divider()
                    HStack {
                        Text("Address:")
                        Spacer()
                        Text(contact.address ?? "Failed to load Contact")
                    }}
                
                Divider()
                HStack {
                    Text("Phone Number:")
                    Spacer()
                    
                    Text(contact.phone?.formatPhoneNumber() ?? "Failed to load Contact")
                }
            }
            .padding()
            .onLongPressGesture(perform: {
                showAlert = true
                selectedContact = contact
                alertTitle = "Delete Contact?"
            })
        }
    }
}
