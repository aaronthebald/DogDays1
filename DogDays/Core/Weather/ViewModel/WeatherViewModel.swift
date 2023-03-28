//
//  WeatherViewModel.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/28/23.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    
    @Published var weather: [WeatherData] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
     getPosts()
    }
    
    func fix() {
        
            
    }
    
    func getPosts() {
        
       guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=33.99&longitude=-81.07&daily=weathercode,temperature_2m_max&temperature_unit=fahrenheit&windspeed_unit=mph&timezone=auto") else { return }
        
        
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
           // .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
           .decode(type: [WeatherData].self, decoder: JSONDecoder())
            //.decode(type: [Daily].self, decoder: DailyUnits(from: JSONDecoder() as! Decoder))
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] returnedWeather in
                self?.weather = returnedWeather
            })
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
        let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
   
}
