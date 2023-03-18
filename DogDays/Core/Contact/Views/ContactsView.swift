//
//  ContactsView.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/14/23.
//

import SwiftUI

struct ContactsView: View {
    
    @StateObject private var vm: ContactViewModel = ContactViewModel()
    
    @State var showAddContactView: Bool = false
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
        ForEach(vm.Contacts) { contact in
            VStack(spacing: 5) {
                HStack {
                    Text("Name:")
                    Spacer()
                    Text(contact.name)
                }
                Divider()
                HStack {
                    Text("Category:")
                    Spacer()
                    Text(contact.category)
                }
                Divider()
                if contact.address.isEmpty {
                    EmptyView()
                } else {
                    HStack {
                    Text("Address:")
                    Spacer()
                    Text(contact.address)
                }}
                
                Divider()
                HStack {
                    Text("Phone Number:")
                    Spacer()
                    
                    Text(contact.phone.formatPhoneNumber())
                }
            }
        }
        .onDelete(perform: vm.deleteContact)
    }
}
