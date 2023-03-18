//
//  EventDetailView.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/17/23.
//

import SwiftUI
import MapKit

struct EventDetailView: View {
    
    @ObservedObject var vm: HomeViewModel
    
    let event: Event
    
    var body: some View {
        NavigationStack {
            VStack() {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(radius: 10)
                    .overlay(content: {
                        Image(systemName: vm.getImage(event: event))
                            .resizable()
                            .frame(width: 100, height: 100)
                    })
                    .frame(width: 200, height: 200)
                VStack(alignment: .leading, spacing: 20) {
                    Text(event.title)
                        .font(.largeTitle)
                    
                    Text(event.type)
                        .font(.largeTitle)
                    
                    Text("\(event.date.formatted(date: .abbreviated, time: .shortened))")
                        .font(.largeTitle)

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
               Spacer()
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        
                    } label: {
                        Text("Edit")
                    }

                }
            }
        }
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailView(vm: dev.homeVM, event: dev.event)
    }
}
