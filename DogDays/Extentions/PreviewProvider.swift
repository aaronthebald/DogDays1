//
//  PreviewProvider.swift
//  DogDays
//
//  Created by Aaron Wilson on 3/11/23.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}



class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() { }
    
    let homeVM = HomeViewModel()
    let event = Event(type: "Goomer", location: "Catwalk", date: Date(), title: "Puppy cut", notification: false, id: UUID().uuidString)
}
