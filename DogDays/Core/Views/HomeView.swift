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
    @State var selectedEvent: EventEntity? = nil
    @State private var showAlert: Bool = false
    @State var alertTitle: String = ""
        
    
    let columns: [GridItem] = [
        GridItem(.flexible(), alignment: .top),
        GridItem(.flexible(), alignment: .top)
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
                    EventTileView(item: item, vm: vm, selectedEvent: $selectedEvent, showAllDetails: showAllDetails )
                }
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
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(selectedEvent != nil ? .blue : .gray)
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
                    .tint(selectedEvent != nil ? .red : .gray)
                }
                
            .padding(.horizontal)
            
        }
    }
}
