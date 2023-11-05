//
//  HomeView.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/8/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State var showAddSheet: Bool = false
    @State var showContactSheet: Bool = false
    @State private var showEditSheet: Bool = false
    @State var selectedEvent: EventEntity? = nil
    @State private var showAlert: Bool = false
    @State var alertTitle: String = ""
    var timeChoices: [String] = ["Future Events", "Past Events"]
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(alignment: .leading) {
            topIcons
            Text(vm.isShowingFutureEvents ? "Upcoming events" : "Past Events")
                .padding(.horizontal)
                .font(.title)
            if vm.events.isEmpty {
                Spacer(minLength: 100)
                welcomeBubble
            } else {
                Picker(selection: $vm.timeFrame) {
                    ForEach(timeChoices, id: \.self) { time in
                            Text(time)
                    }
                } label: {
                    
                }
                .pickerStyle(.segmented)
                if vm.sortedEvents.isEmpty {
                        Text(vm.isShowingFutureEvents ? "No Future Events Scheduled" : "No Past Events Saved")
                            .padding(.horizontal)
                            .padding(.vertical)
                }
                List(content: {
                    ForEach(vm.sortedEvents) { event in
                        EventCard(item: event, vm: vm)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button {
                                    selectedEvent = event
                                    showAlert = true
                                } label: {
                                    Image(systemName: "trash")
                                        .tint(.red)
                                }
                                
                                Button {
                                    selectedEvent = event
                                    showEditSheet = true
                                } label: {
                                    Label("Edit", systemImage: "square.and.pencil")
                                }
                            }
                    }
                })
                .listStyle(.plain)
                .listRowSeparator(.visible)
            }
            Spacer()
        }
        .onChange(of: vm.timeFrame, perform: { newValue in
            vm.applyChanges()
        })
        .padding(.horizontal, 4)
        .onAppear {
            NotificationManager.instance.requestAuthorization()
        }
        
        .alert("Are you sure?", isPresented: $showAlert, actions: {alertView})
        .sheet(isPresented: $showContactSheet) {
            ContactsView(showContactSheet: $showContactSheet)
        }
        .sheet(isPresented: $showAddSheet, content: {
            AddEventView(vm: vm, showAddSheet: $showAddSheet)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        })
        .sheet(isPresented: $showEditSheet, content: {
            EditEventView(vm: vm, selectedEvent: $selectedEvent, showEditSheet: $showEditSheet)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        })
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
        }
    }
}

extension HomeView {
    
    private var topIcons: some View {
        HStack {
            Image(systemName: "person.text.rectangle")
                .foregroundColor(Color.theme.accent)
                .onTapGesture {
                    showContactSheet.toggle()
                }
            Spacer()
            
            Image(systemName: "plus.square")
                .foregroundColor(Color.theme.accent)
                .onTapGesture {
                    showAddSheet.toggle()
                }
        }
        .font(.largeTitle)
        .padding(.horizontal)
        .padding(.bottom)

    }
    
    private var welcomeBubble: some View {
        HStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 25)
                .fill(colorScheme == .light ? Color.white : Color.black)
                .shadow(color: colorScheme == .light ? .black : .white, radius: 10)
                .overlay(
                Text("Welcome to DogDays! Click the plus icon in the top right corner to add your first event and get started!")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                )
                .frame(width: 300, height: 175)
                
                
        }
        .frame(maxWidth: .infinity)
    }
    
    private var alertView: some View {
        HStack {
            Button {
                selectedEvent = nil
                showAlert.toggle()
            } label: {
                Text("Cancel")
            }
            Button {
                if let deletedEvent = selectedEvent {
                    vm.delete(entity: deletedEvent)
                    selectedEvent = nil
                } else {
                    print("Error deleting selected event")
                }
            } label: {
                Text("DELETE")
        }
        }
    }
    
}
