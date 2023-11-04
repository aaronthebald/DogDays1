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
                HStack {
                    Text("Days until: ")
                    Text(timePeriodTest(date: item.date!).description)
                }
                Text(item.date?.formatted(date: .abbreviated, time: .shortened) ?? "Event has no date")

            }
            Spacer()
            Image(systemName: vm.getImage(event: item))
                .font(.title)
                .foregroundColor(Color.theme.accent)
        }        
    }
}

extension EventCard {
    func timePeriodTest(date: Date) -> Int {
        let userDate = Calendar.current.dateComponents([.day, .month, .year], from: date)
        
        let userDateComponents = DateComponents(calendar: Calendar.current, year: userDate.year!, month: userDate.month!, day: userDate.day!).date!
        
        let daysUntil = Calendar.current.dateComponents([.day], from: Date(), to: userDateComponents)
        
        return daysUntil.day!
    }
}


