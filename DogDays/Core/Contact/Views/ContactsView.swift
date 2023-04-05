//
//  ContactsView.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/14/23.
//

import SwiftUI

struct ContactsView: View {
    
    @StateObject private var vm: ContactViewModel = ContactViewModel()
    
    @State var buttonTitle: String = ""
    @State private var shadowAnimation: Bool = false
    @State private var showAlert: Bool = false
     var alertTitle: String = "Delete Contact?"
    @State var showAddContactView: Bool = false
    @State var selectedContact: ContactEntity? = nil
    @Binding var showContactSheet: Bool
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        NavigationStack() {
            if vm.contacts.isEmpty {
                VStack {
                    Spacer(minLength: 100)
                    contactBubble
                        .frame(maxHeight: .infinity)
                }
            }
            VStack {
                ForEach(vm.contacts) { contact in
                    ContactCardView(contact: contact, vm: vm, selectedContact: $selectedContact)
                }
                    Spacer()
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
                    ToolbarItem(placement: .destructiveAction) {
                        Button {
                            if selectedContact != nil {
                                showAlert = true
                            }
                        } label: {
                            Text("Delete")
                        } .tint(selectedContact == nil ? .gray : Color.theme.accent)
                    }
                
                
                ToolbarItem(placement:.navigationBarTrailing) {
                    Button {
                        showAddContactView.toggle()
                    } label: {
                        Image(systemName: showAddContactView ? "xmark" : "plus")
                    }
        }
      }
            .tint(Color.theme.accent)
    }

        .alert(alertTitle, isPresented: $showAlert, actions: {
                HStack {
                    Button {
                        showAlert = false
                    } label: {
                        Text("Dismiss")
                    }
                    Button {
                       if let selectedContact = selectedContact  {
                            vm.deleteContact(deletedEntity: selectedContact)
                        }
                        selectedContact = nil
                    } label: {
                        Text("DELETE")
                    }
                }
            
        }
        )
        .sheet(isPresented: $showAddContactView) {
            AddContactView(vm: vm, showAddContactView: $showAddContactView)
                .presentationDetents([.height(400)]).presentationDragIndicator(.visible)
        }
  }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView( showContactSheet: .constant(false))
    }
}

extension ContactsView {
    private var contactBubble: some View {
        HStack() {
            RoundedRectangle(cornerRadius: 25)
                .fill(colorScheme == .light ? Color.white : Color.black)
                .shadow(color: colorScheme == .light ? .black : .white, radius: 14)
                .overlay(
                Text("On this screen you can keep up with important Contacts for your pup! Press the plus button to get started!")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                )
                .frame(width: 350, height: 200)
        }
        .frame(maxWidth: .infinity)
    }

}
