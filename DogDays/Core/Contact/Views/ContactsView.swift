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
                if selectedContact != nil {
                    ToolbarItem(placement: .destructiveAction) {
                        Button {
                            showAlert = true
                        } label: {
                            Text("Delete")
                        }

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
            .tint(Color.theme.accent)
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
    
//    private var contactCard: some View {
//        ForEach(vm.contacts) { contact in
//            VStack(spacing: 5) {
//
//                HStack {
//                    Text("Name:")
//                    Spacer()
//                    Text(contact.name ?? "Failed to load Contact")
//                }
//                Divider()
//                HStack {
//                    Text("Category:")
//                    Spacer()
//                    Text(contact.category ?? "Failed to load Contact")
//                }
//
//                if ((contact.address?.isEmpty) != nil) {
//                    EmptyView()
//                } else {
//                    Divider()
//                    HStack {
//                        Text("Address:")
//                        Spacer()
//                        Text(contact.address ?? "Failed to load Contact")
//                    }}
//
//                Divider()
//                HStack {
//                    Text("Phone Number:")
//                    Spacer()
//
//                    Text(contact.phone?.formatPhoneNumber() ?? "Failed to load Contact")
//                }
//            }
//            .overlay(alignment: .topTrailing, content: {
//                if selectedContact != nil {
//                    overlay
//                }
//            })
//            .padding()
//            .background(Color.white)
//            .cornerRadius(15)
//            .padding()
//            .shadow(color: .black.opacity(0.25), radius: 10)
//            .frame(maxWidth: .infinity)
//
//
//            .onLongPressGesture(perform: {
//                buttonTitle = "checkmark.circle"
//                selectedContact = contact
//                alertTitle = "Delete Contact?"
//            })
//        }
//
//    }
    
    
    private var contactBubble: some View {
        HStack() {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .shadow(color: .black, radius: 14)
                .overlay(
                Text("On this screen you can keep up with important Contacts for your pup! Press the plus button to get started!")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                )
                .frame(width: 300, height: 175)
                
                
        }
        
        
        .frame(maxWidth: .infinity)
    }
    
//    private var overlay: some View {
//        Button {
//            selectedContact = nil
//       } label: {
//           Image(systemName: "checkmark.circle")
//               .font(.largeTitle)
//       }
//
//    }
}
