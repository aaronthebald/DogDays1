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
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var selectedEvent: EventEntity?
    @State var buttonTitle: String = ""
    @State var backgroundColor: Color = Color.white
    
    
    
    var body: some View {
        
        ZStack {
            if colorScheme == .light {
                Color.white
            } else {
                Color.black
            }
            VStack( alignment: .leading) {
                HStack {
                    Spacer()
                    Image(systemName: vm.getImage(event: item))
                                .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color.theme.accent)
                }
                Text(item.title ?? "")
                            //.font(.headline)
//                            .lineLimit(1)
//                            .scaledToFit()
                Text(item.location ?? "")
//                            .font(.headline)
//                            .lineLimit(1)
                Text(item.date?.formatted(date: .abbreviated, time: .omitted) ?? "")
//                    .multilineTextAlignment(.leading)
//                    .font(.headline)
                Text(item.date?.formatted(date: .omitted, time: .shortened) ?? "")
//                    .multilineTextAlignment(.leading)
//                    .font(.headline)
                            
                            Spacer()
                        
                    }
                    .padding()
                    .padding(.top, 8)
                }
               // .frame(width: 175, height: 160)
                .overlay(alignment: .topLeading) {
                        if selectedEvent == item{
                            overlay
                            }
                        }
                .onLongPressGesture(perform: {
                    HapticManager.instance.notification(type: .success)
                        buttonTitle = "checkmark.circle"
                        selectedEvent = item
                        })
                    .cornerRadius(15)
                    .shadow(color: colorScheme == .light ? .black.opacity(0.3) : .white.opacity(0.3), radius: 15)
        
        }
    }

extension EventTileView {
    private var overlay: some View {
        Button {
            selectedEvent = nil
       } label: {
           Image(systemName: buttonTitle)
               .foregroundColor(Color.theme.accent)
               .font(.largeTitle)
       }

    }
}

