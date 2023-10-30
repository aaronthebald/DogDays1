//
//  EventCard.swift
//  DogDays
//
//  Created by Aaron Wilson on 10/26/23.
//

import SwiftUI

struct EventCard: View {
    let item: EventEntity
    @ObservedObject var vm: HomeViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title ?? "Event has no title")
                    .font(.headline)
                Text(item.location ?? "Event has no Location")
                    .font(.subheadline)
                Text(item.date?.formatted(date: .abbreviated, time: .shortened) ?? "Event has no date")
            }
            Spacer()
            Image(systemName: vm.getImage(event: item))
                .font(.title)
                .foregroundColor(Color.theme.accent)
        }        
    }
}


