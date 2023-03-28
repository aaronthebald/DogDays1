//
//  EditEventView.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/20/23.
//

import SwiftUI

struct EditEventView: View {
    @ObservedObject  var vm: HomeViewModel
    
    @Binding var selectedEvent: EventEntity?
    @State var newEventLocation: String = ""
    @State var newEventTitle: String = ""
    @State var newEventSelection: String = "Test"
    @State var newEventDate: Date = Date()
    @State var newEventNotificationBool: Bool = false
    @State var eventTypes: [String] = [
        "Groomer", "Vet Visit", "Medication", "Task for Owner", "PlayDate"
    ]
    
    @Binding var showEditSheet: Bool
    
    
    
        
    
    var body: some View {
        
        
        ZStack {
            VStack {
                newEventTitleView
                saveButton
            }
            .padding()
            
            .cornerRadius(20)
            
        }
        .onAppear{
            
            setValues()
        }
        .frame(height: 500)
        .background(.thinMaterial).ignoresSafeArea()
    }
}

//struct EditEventView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditEventView(vm: dev.homeVM, selectedEvent: .constant(dev.event), showEditSheet: .constant(true))
//    }
//}

extension EditEventView {
    private var newEventTitleView: some View {
        VStack {
            if let selectedEvent = selectedEvent  {
                
                TextField(selectedEvent.title ?? "Help me", text: $newEventTitle)
                
                Divider()
                
                TextField(selectedEvent.location ?? "Help me", text: $newEventLocation)
                
                Divider()
                
                HStack {
                    Text("Event Type:")
                    Spacer()
                    Picker(selectedEvent.type ?? "Help me", selection: $newEventSelection) {
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
           

        }
        .padding()
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(10)

        
        
    }
    private var saveButton: some View {
        HStack {
            Spacer()
            Button {
                
                if let selectedEvent = selectedEvent {
                        
                        print(selectedEvent as Any)
                        vm.updateEvent(event: returnUpdatedEvent(selectedEvent: selectedEvent))
                        if newEventNotificationBool == true {
                        NotificationManager.instance.scheduleNotification(forDate: newEventDate)
                        }
                        print("closure ran")
                        showEditSheet.toggle()
                        print(vm.events.count)
                    
                        
                }
                selectedEvent = nil
            }
                label: {
                Text("Save")
            }
            .buttonStyle(BorderedProminentButtonStyle())
        }
    }
    
    func setValues() {
        if let event = selectedEvent {
            newEventTitle = event.title ?? "Help me"
            newEventLocation = event.location ?? "Help me"
            newEventSelection = event.type ?? "Help me"
            newEventDate = event.date ?? Date()
            newEventNotificationBool = event.notification
        }
    }
    
    func returnUpdatedEvent(selectedEvent: EventEntity) -> EventEntity {
        let updatedEvent = selectedEvent
            if newEventNotificationBool != selectedEvent.notification {
                let newEvent = Event(type: selectedEvent.type ?? "Error", location: selectedEvent.location ?? "Error", date: selectedEvent.date ?? Date(), title: selectedEvent.title ?? "Error", notification: newEventNotificationBool, id: selectedEvent.id ?? "Error")
                updatedEvent.title = newEvent.title
                updatedEvent.location = newEvent.location
                updatedEvent.type = newEvent.type
                updatedEvent.date = newEvent.date
                updatedEvent.notification = newEvent.notification
                updatedEvent.id = newEvent.id
            }
            else if newEventDate != selectedEvent.date {
                let newEvent = Event(type: selectedEvent.type ?? "error" , location: selectedEvent.location ?? "error", date: newEventDate, title: selectedEvent.title ?? "error", notification: selectedEvent.notification, id: selectedEvent.id ?? "error")
                updatedEvent.title = newEvent.title
                updatedEvent.location = newEvent.location
                updatedEvent.type = newEvent.type
                updatedEvent.date = newEvent.date
                updatedEvent.notification = newEvent.notification
                updatedEvent.id = newEvent.id
            }
            else if newEventLocation != selectedEvent.location {
                let newEvent = Event(type: selectedEvent.type ?? "error", location: newEventLocation, date: selectedEvent.date ?? Date(), title: selectedEvent.title ?? "error", notification: selectedEvent.notification, id: selectedEvent.id ?? "error")
                updatedEvent.title = newEvent.title
                updatedEvent.location = newEvent.location
                updatedEvent.type = newEvent.type
                updatedEvent.date = newEvent.date
                updatedEvent.notification = newEvent.notification
                updatedEvent.id = newEvent.id
            }
            else if newEventTitle != selectedEvent.title {
                let newEvent = Event(type: selectedEvent.type ?? "error", location: selectedEvent.location ?? "error", date: selectedEvent.date ?? Date(), title: newEventTitle, notification: selectedEvent.notification, id: selectedEvent.id ?? "error")
                updatedEvent.title = newEvent.title
                updatedEvent.location = newEvent.location
                updatedEvent.type = newEvent.type
                updatedEvent.date = newEvent.date
                updatedEvent.notification = newEvent.notification
                updatedEvent.id = newEvent.id
            }
            else if newEventSelection != selectedEvent.type {
                let newEvent = Event(type: newEventSelection, location: selectedEvent.location ?? "error", date: selectedEvent.date ?? Date(), title: selectedEvent.title ?? "error", notification: selectedEvent.notification, id: selectedEvent.id ?? "error")
                updatedEvent.title = newEvent.title
                updatedEvent.location = newEvent.location
                updatedEvent.type = newEvent.type
                updatedEvent.date = newEvent.date
                updatedEvent.notification = newEvent.notification
                updatedEvent.id = newEvent.id
            }
        
        
        print("Selected event is updated")
        print(updatedEvent)
        return updatedEvent
       
    }
}
