//
//  EventTileView.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/21/23.
//

import SwiftUI

struct EventTileView: View {
    
    let item: Event
    @ObservedObject var vm: HomeViewModel
    
    @Binding var selectedEvent: Event?
    @State var animate: Bool = false
    @State var buttonTitle: String = ""
    @State var showAllDetails: Bool
    
    @State var backgroundColor: Color = Color.white
    
    
    
    var body: some View {
        
        ZStack {
            backgroundColor.animation(.none)
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
                    .overlay(alignment: .topTrailing) {
                        if selectedEvent != nil {
                            overlay
                            }
                        }
                    .rotationEffect(.degrees(animate ? 2.5 : 0))
                    .animation(animate ? .easeInOut(duration: 0.15).repeatForever(autoreverses: true) : .easeInOut(duration: 0.15), value: animate)
                    .onTapGesture {
                        withAnimation {
                            showAllDetails.toggle()
                            }
                        }
                    .onLongPressGesture(perform: {
                        buttonTitle = "checkmark.circle"
                        selectedEvent = item
                        animate = true
                        })
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.3), radius: 10)
        
        }
    }

extension EventTileView {
    private var overlay: some View {
        Button {
            animate.toggle()
            selectedEvent = nil
       } label: {
           Image(systemName: buttonTitle)
               .font(.largeTitle)
       }

    }
}

