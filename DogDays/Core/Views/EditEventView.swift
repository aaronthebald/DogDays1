//
//  EditEventView.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/20/23.
//

import SwiftUI

struct EditEventView: View {
    @ObservedObject  var vm: HomeViewModel
    
    @Binding var selectedEvent: Event?
    
    @State var newEventLocation: String = ""
    @State var updatedEvent: Event?
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

struct EditEventView_Previews: PreviewProvider {
    static var previews: some View {
        EditEventView(vm: dev.homeVM, selectedEvent: .constant(dev.event), showEditSheet: .constant(true))
    }
}

extension EditEventView {
    private var newEventTitleView: some View {
        VStack {
            if let selectedEvent = selectedEvent {
                
                TextField(selectedEvent.title, text: $newEventTitle)
                
                Divider()
                
                TextField(selectedEvent.location, text: $newEventLocation)
                
                Divider()
                
                HStack {
                    Text("Event Type:")
                    Spacer()
                    Picker(selectedEvent.type, selection: $newEventSelection) {
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
                showEditSheet.toggle()
                if let selectedEvent = selectedEvent {
                    vm.updateEvent(event: returnUpdatedEvent(selectedEvent: selectedEvent) ?? selectedEvent)
                }
            }
                label: {
                Text("Save")
            }
            .buttonStyle(BorderedProminentButtonStyle())
        }
    }
    
    func setValues() {
        if let event = selectedEvent {
            newEventTitle = event.title
            newEventLocation = event.location
            newEventSelection = event.type
            newEventDate = event.date
            newEventNotificationBool = event.notification
        }
    }
    
    func returnUpdatedEvent(selectedEvent: Event?) -> Event? {
        if let selectedEvent = selectedEvent {
            if newEventNotificationBool != selectedEvent.notification {
                let newEvent = Event(type: selectedEvent.type, location: selectedEvent.location, date: selectedEvent.date, title: selectedEvent.title, notification: newEventNotificationBool, id: selectedEvent.id)
                updatedEvent = newEvent
            }
            else if newEventDate != selectedEvent.date {
                let newEvent = Event(type: selectedEvent.type, location: selectedEvent.location, date: newEventDate, title: selectedEvent.title, notification: selectedEvent.notification, id: selectedEvent.id)
                updatedEvent = newEvent
            }
            else if newEventLocation != selectedEvent.location {
                let newEvent = Event(type: selectedEvent.type, location: newEventLocation, date: selectedEvent.date, title: selectedEvent.title, notification: selectedEvent.notification, id: selectedEvent.id)
                updatedEvent = newEvent
            }
            else if newEventTitle != selectedEvent.title {
                let newEvent = Event(type: selectedEvent.type, location: selectedEvent.location, date: selectedEvent.date, title: newEventTitle, notification: selectedEvent.notification, id: selectedEvent.id)
                updatedEvent = newEvent
            }
            else if newEventSelection != selectedEvent.type {
                let newEvent = Event(type: newEventSelection, location: selectedEvent.location, date: selectedEvent.date, title: selectedEvent.title, notification: selectedEvent.notification, id: selectedEvent.id)
                updatedEvent = newEvent
            }
        }
        return updatedEvent
    }
}
