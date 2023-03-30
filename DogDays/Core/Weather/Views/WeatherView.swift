//
//  WeatherView.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/28/23.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject private var wvm: WeatherViewModel
    var body: some View {
        Text("Hello again")
            Text("Today the temp is...")
        Text(wvm.days.first?.temperature2MMax ?? "Error")
        Button {
            wvm.getPosts()
        } label: {
            Text("Button")
        }

    }
    
}

//struct WeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherView()
//    }
//}
