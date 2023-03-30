//
//  WeatherViewModel.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/28/23.
//

import Foundation
import Combine
import SwiftUI

class WeatherViewModel: ObservableObject {
    
    @Published var weather: [Welcome] = []
    @Published var days: [DailyUnits] = []
    @Published var posts: [PostModel] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
     getPosts()
        fix()
        print(weather.count)
    }
    
    func fix() {
        if let newItem = weather.first?.dailyUnits {
            days.append(newItem)
            print("Something")
        }
        print("Error creating newItem")
    }
    
    func getPosts() {
        
       guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=33.89&longitude=-81.13&daily=weathercode,temperature_2m_max&temperature_unit=fahrenheit&windspeed_unit=mph&precipitation_unit=inch&forecast_days=1&start_date=2023-03-29&end_date=2023-04-04&timezone=America%2FNew_York") else {
           print("Failed to get URL")
           return }
        
        
        // Combine discussion
        /*
        // 1. sign up for monthly subscription for package to be delivered
        // 2. the company would make the package behind the scene
        // 3. recieve the package at your front door
        //4. make sure the box isn't damaged
        // 5. open and make sure the item is correct
        // 6. use the item!!!!
        // 7. cancellable at any time!!
        
        // 1. create publisher
        // 2. subscribe publisher on background thread
        // 3. receive on main thread
        // 4. tryMap (check that data is good)
        // 5. decode (decode data into postsmodels)
        // 6. sink (put item into our app)
        // 7. store (cancel subscription if needed)
        */
         
        URLSession.shared.dataTaskPublisher(for: url)
       //     .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [Daily : DailyUnits].self, decoder: JSONDecoder()).print()
            .replaceError(with: [ : ])
            .sink(receiveValue: {  returnedWeather in
                //self.days = returnedWeather
            })
            .store(in: &cancellables)
        print("GetPost ran")
       
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
        let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            print("Crappy URL")
            throw URLError(.badServerResponse)
        }
        print(output.data.debugDescription)
        return output.data
    }
}
