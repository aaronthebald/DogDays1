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
    @State var shadowAnimation: Bool = false
    let columns: [GridItem] = [
        GridItem(.flexible(), alignment: .top),
        GridItem(.flexible(), alignment: .top)
]
    
    var body: some View {
        
            ZStack {
                ScrollView {
                    topIcons
                    VStack(alignment: .leading) {
                        
                       upccomingEventsHeader
                        if vm.events.isEmpty {
                            Spacer(minLength: 100)
                            welcomeBubble
                        }
                        eventGrid
                    }
                    .sheet(isPresented: $showAddSheet) {
                        AddEventView(vm: vm, showAddSheet: $showAddSheet)
                            .presentationDetents([.height(330)]).presentationDragIndicator(.visible)
                    }
                }
            }
            .onAppear {
                NotificationManager.instance.requestAuthorization()
            }
        			
            .alert("Are you sure?", isPresented: $showAlert, actions: {
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

            })
            .sheet(isPresented: $showContactSheet) {
                ContactsView(showContactSheet: $showContactSheet)
            }
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

    
    private var eventGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: 20,
            pinnedViews: []) {
                ForEach(vm.events) { item in
                    EventTileView(item: item, vm: vm, selectedEvent: $selectedEvent)
                }
                .padding(.horizontal, 8)
                .padding(.top)
            }
    }
    
    private var upccomingEventsHeader: some View {
        VStack {
            Text("Upcoming Events.")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
                    HStack {
                        Button {
                            if selectedEvent != nil {
                                showEditSheet.toggle()
                            }
                        } label: {
                            Text("Edit")
                        }
                        
                        .buttonStyle(BorderedProminentButtonStyle())
                        .tint(selectedEvent != nil ? .theme.accent.opacity(0.75) : .gray)
                        .sheet(isPresented: $showEditSheet) {
                            EditEventView(vm: vm, selectedEvent: $selectedEvent, showEditSheet: $showEditSheet)
                                .presentationDetents([.height(330)]).presentationDragIndicator(.visible)
                        }
                        Spacer()
                        
                            Button {
                                if selectedEvent != nil {
                                    showAlert.toggle()
                                }
                            } label: {
                                Text("DELETE")
                            }
                            .buttonStyle(BorderedProminentButtonStyle())
                            .tint(selectedEvent != nil ? .red.opacity(0.85) : .gray)
                        }
                        .padding(.horizontal)
                        
                
            
            
        }
    }
    private var welcomeBubble: some View {
        HStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .shadow(color: .black, radius: shadowAnimation ? 14 : 10)
                .overlay(
                Text("Welcome to DogDays! Click the plus icon in the top right corner to add your first event and get started!")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                )
                .frame(width: 300, height: 175)
                
                
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                shadowAnimation = true
            }
        }
        
        .frame(maxWidth: .infinity)
    }
}
