//
//  Destination.swift
//  SwiftData-TravelApp
//
//  Created by Ege Kaygisizer on 22.03.2025.
//

import Foundation
import SwiftData

@Model // Load and save destination object inside permanent storage..
class Destination {
    var name: String
    var details: String
    var date: Date
    var priority: Int
    @Relationship(deleteRule: .cascade) var sights = [Sight]()
    //RelationShip means when delete the destination delete all the sights array.. 
    
    init(name: String = "", details: String = "", date: Date = .now, priority: Int = 2) {
        self.name = name
        self.details = details
        self.date = date
        self.priority = priority
    }
}
