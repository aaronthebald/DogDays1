//
//  EventTileView.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/21/23.
//

import SwiftUI

struct EventTileView: View {
    
    let item: EventEntity
    @ObservedObject var vm: HomeViewModel
    
    @Binding var selectedEvent: EventEntity?
    @State var animate: Bool = false
    @State var buttonTitle: String = ""
    @State var showAllDetails: Bool
    @State var backgroundColor: Color = Color.white
    
    
    
    var body: some View {
        
        ZStack {
            backgroundColor.animation(.none)
            VStack( alignment: .leading) {
                HStack {
                    Spacer()
                    Image(systemName: vm.getImage(event: item))
                                .resizable()
                            .frame(width: 40, height: 40)
                }
                Text(item.title ?? "")
                            .font(.headline)
                            .lineLimit(1)
                Text(item.location ?? "")
                            .font(.headline)
                            .lineLimit(1)
                Text(item.date?.formatted(date: .abbreviated, time: .omitted) ?? "")
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                    .padding(.horizontal, 4)
                Text(item.date?.formatted(date: .omitted, time: .shortened) ?? "")
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                    .padding(.horizontal, 4)
                            
                            Spacer()
                        
                    }
                    .padding()
                    .padding(.top, 8)
                }
                .frame(width: 175, height: 160)
                .overlay(alignment: .topLeading) {
                        if selectedEvent == item{
                            overlay
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
            animate = false
            selectedEvent = nil
       } label: {
           Image(systemName: buttonTitle)
               .font(.largeTitle)
       }

    }
}

