//
//  HomeView.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/8/23.
//

import SwiftUI

struct HomeView: View {

    @StateObject  var vm: HomeViewModel
    @State var showAddSheet: Bool = false
    @State var showContactSheet: Bool = false
    @State private var showEditSheet: Bool = false
    @State var showAllDetails: Bool = false
    @State var selectedEvent: Event? = nil
    @State private var showAlert: Bool = false
    @State var alertTitle: String = ""
    @State private var animate: Bool = false
    
    
    let columns: [GridItem] = [
    GridItem(.flexible()),
    GridItem(.flexible())
]
    
    var body: some View {
        
            ZStack {
                ScrollView {
                    topIcons
                    VStack(alignment: .leading) {
                        
                        weatherView
                        Spacer(minLength: 30)
                        upccomingEventsHeader
                        eventGrid
                        
                    }
                    .sheet(isPresented: $showAddSheet) {
                        AddEventView(vm: vm, showAddSheet: $showAddSheet)
                            .presentationDetents([.height(330)]).presentationDragIndicator(.visible)
                    }
                }
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
                            vm.deleteEvent(event: deletedEvent)
                            selectedEvent = nil
                            animate = false
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
            HomeView(vm: dev.homeVM)
        }
        
    }
}

extension HomeView {
    
    
    
    private var topIcons: some View {
        HStack {
            Image(systemName: "exclamationmark.square")
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
    
    // Weather view with a 5 day outlook will need to be built
    private var weatherView: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(height: 100)
            .foregroundColor(Color.theme.dark)
            .overlay(Text("This is the weather view"))
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            
    }
    
    private var eventGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: 20,
            pinnedViews: []) {
                ForEach(vm.events) { item in
                        ZStack {
                                Color.white
                            VStack {
                                Image(systemName: vm.getImage(event: item))
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                    Text(item.title)
                                            .font(.title2)
                                            .lineLimit(1)
                                    Text(item.location)
                                            .font(.title2)
                                            .lineLimit(1)
                                    Spacer()
                                    if showAllDetails {
                                        withAnimation {
                                            Text(item.date.formatted(date: .abbreviated, time: .shortened))
                                                    .font(.title2)
                                                    .padding(.horizontal, 4)
                                            }
                                            Spacer()
                                        }
                                    }
                                    .padding(.top, 8)
                                
                            }
                        .rotationEffect(.degrees(animate ? 2.5 : 0))
                        .animation(animate ? .easeInOut(duration: 0.15).repeatForever(autoreverses: true) : .easeInOut(duration: 0.15), value: animate)
                       
                        
                            .onTapGesture {
                                withAnimation {
                                    showAllDetails.toggle()
                                }
                            }
                            .onLongPressGesture(perform: {
                                animate = true
                                selectedEvent = item
                            })
                            .cornerRadius(10)
                        .shadow(color: .black.opacity(0.3), radius: 10)
                    
                      //  .frame(width: 125, height: 125)
                    }
                    .frame(width: 150, height: showAllDetails ? 225 : 150)
                
                .padding(.leading, 8)
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
                .sheet(isPresented: $showEditSheet) {
                    EditEventView(vm: vm, selectedEvent: $selectedEvent, showEditSheet: $showEditSheet)
                        .presentationDetents([.height(330)]).presentationDragIndicator(.visible)
                }
                Button {
                    animate = false
                    selectedEvent = nil
                } label: {
                    Text("Cancel")
                }

                Spacer()
                
                    Button {
                        if selectedEvent != nil {
                            showAlert.toggle()
                            animate.toggle()
                        }
                    } label: {
                        Text("DELETE")
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    .tint(selectedEvent != nil ? .red : .gray)
                }
                
            .padding(.horizontal)
            
        }
    }
}
