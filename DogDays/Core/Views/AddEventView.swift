//
//  AddEventView.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/10/23.
//

import SwiftUI

struct AddEventView: View {
    
    @ObservedObject  var vm: HomeViewModel
    

    @State var newEventLocation: String = ""
    @State var newEventTitle: String = ""
    @State var newEventSelection: String = "Test"
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
               

//                Picker("Event Type", selection: $newEventSelection) {
//                    ForEach(eventTypes, id: \.self) { type in
//                        Text("\(type)")
//                            .tag("\(type)")
//                    }
//                }
//                .pickerStyle(MenuPickerStyle())
            
            Divider()
            DatePicker("Date", selection: $newEventDate)
            Divider()
            Toggle("Schedule Notifcation?", isOn: $newEventNotificationBool)

        }
        .padding()
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(10)
       // .padding(6)

        
        
    }
    private var saveButton: some View {
        HStack {
            Spacer()
            Button {
                
//                vm.textVM()
                let newEvent = Event(type: newEventSelection, location: newEventLocation, date: newEventDate, title: newEventTitle, notification: newEventNotificationBool, id: UUID().uuidString)
                print("Button pressed")
                vm.add(event: newEvent)
                showAddSheet.toggle()
                
            } label: {
                Text("Save")
//                Circle()
//                    .frame(width: 60)
//                    //.padding()
//                    .padding(.horizontal)
//                    .overlay {
//                        Text("SAVE")
//                            .foregroundColor(Color.theme.light)
//                            .font(.headline)
//                    }
//                    .foregroundColor(Color.theme.accent)
//                    .cornerRadius(10)
            }
            .buttonStyle(BorderedProminentButtonStyle())
        }
    }
    
}
