//
//  ContactCardView.swift
//  DogDays
//
//  Created by Aaron Wilson on 4/2/23.
//

import SwiftUI



struct ContactCardView: View {
    
    let contact: ContactEntity
    @ObservedObject var vm: ContactViewModel
    @Environment(\.colorScheme) private var colorScheme
    @Binding var selectedContact: ContactEntity?
    let url = URL(string: "https://www.youtube.com/")
    let tel = "tel:"
    
    var body: some View {
        
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
            Divider()
            HStack {
                Text("Phone Number:")
                Spacer()
                
                Link(contact.phone?.formatPhoneNumber() ?? "Error geting phone number", destination: URL(string: tel + (contact.phone ?? "")) ??  url! )
            }
        }
        
        .frame(height: 85)
        .frame(maxWidth: .infinity)
        .padding()
        .background()
        .cornerRadius(15)
        .padding()
        .overlay(alignment: .topTrailing) {
            if selectedContact == contact {
                overlay
                    
            }
        }
        .shadow(color: colorScheme == .light ? .black.opacity(0.25) : .white.opacity(0.25), radius: 15)


        .onLongPressGesture(perform: {
            HapticManager.instance.notification(type: .success)
            selectedContact = contact
        })
    }
}

//struct ContactCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContactCardView(contact: , vm: <#ContactViewModel#>, selectedContact: <#Binding<ContactEntity?>#>)
//    }
//}

extension ContactCardView {
    
    private var overlay: some View {
        Button {
            selectedContact = nil
       } label: {
           Image(systemName: "xmark.circle")
               .foregroundColor(.red)
               .font(.largeTitle)
       }

    }
}
