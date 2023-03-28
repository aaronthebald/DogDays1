//
//  WeatherView.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/28/23.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var wvm: WeatherViewModel = WeatherViewModel()
    var body: some View {
        Text("Hello world")
        ForEach(wvm.weather) { weather in
            Text(weather.dailyUnits.time)
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
