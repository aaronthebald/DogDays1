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
        ForEach(wvm.days) { day in
            Text("Today the temp is...")
            Text(day.temperature2MMax)
        }
    }
    
}

//struct WeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherView()
//    }
//}
