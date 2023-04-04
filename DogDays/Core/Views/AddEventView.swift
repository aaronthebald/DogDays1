//
//  AddEventView.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/10/23.
//

import SwiftUI

struct AddEventView: View {
    
    @ObservedObject  var vm: HomeViewModel
    
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State var newEventLocation: String = ""
    @State var newEventTitle: String = ""
    @State var newEventSelection: String = "Groomer"
    @State var newEventDate: Date = Date()
    @State var newEventNotificationBool: Bool = false
    @State var eventTypes: [String] = [
        "Groomer", "Vet Visit", "Medication", "Task for Owner", "PlayDate"
    ]
    
    @Binding var showAddSheet: Bool
    
    var body: some View {
        
        ZStack {
            VStack {
                newEventTitleView
                saveButton
            }
            .padding()
            
            .cornerRadius(20)
            
        }
        .alert(alertTitle, isPresented: $showAlert, actions: {
            HStack {
                Button {
                    showAlert.toggle()
                } label: {
                    Text("Dismiss")
                }

            }
        })
        .frame(height: 500)
        .background(.thinMaterial).ignoresSafeArea()
    }
        
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddEventView(vm: dev.homeVM, showAddSheet: .constant(true))
        }
        
        
    }
}

extension AddEventView {
    private var newEventTitleView: some View {
        VStack {
            
            TextField("Event Name... ", text: $newEventTitle)
            
            Divider()
            
            TextField("Event Location... ", text: $newEventLocation)
                
            
            Divider()
            
            HStack {
                Text("Event Type:")
                Spacer()
                Picker("Select Category..", selection: $newEventSelection) {
                    ForEach(eventTypes, id: \.self) { type in
                        Text("\(type)")
                            .tag(type)
                    }
                }
            }

            Divider()
            DatePicker("Date", selection: $newEventDate)
            Divider()
            Toggle("Schedule Notifcation?", isOn: $newEventNotificationBool)

        }
        .padding()
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .background()
        .cornerRadius(10)

        
        
    }
    private var saveButton: some View {
        HStack {
            Spacer()
            Button {
                
                if titleIsApproprate() && locationIsApproprate() {
                    let newEvent = Event(type: newEventSelection, location: newEventLocation, date: newEventDate, title: newEventTitle, notification: newEventNotificationBool, id: UUID().uuidString)
                    print("Button pressed")
                    vm.add(event: newEvent)
                    if newEventNotificationBool == true {
                        NotificationManager.instance.scheduleNotification(forDate: newEventDate)
                    }
                    showAddSheet.toggle()
                }
                
            } label: {
                Text("Save")
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .tint(Color.theme.accent)
        }
    }
    
   
    
    private func titleIsApproprate() -> Bool {
        if newEventTitle.count < 3 {
            alertTitle = "Please add a Title to your event"
            showAlert.toggle()
            return false
        } else {
            return true
        }
    }
    
    private func locationIsApproprate() -> Bool {
        if newEventLocation.count < 3 {
            alertTitle = "Please add a Location to your event"
            showAlert.toggle()
            return false
        } else {
            return true
        }
    }
}
