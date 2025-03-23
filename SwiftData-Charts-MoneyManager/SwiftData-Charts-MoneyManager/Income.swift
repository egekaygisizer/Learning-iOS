//
//  Income.swift
//  SwiftData-Charts-MoneyManager
//
//  Created by Ege Kaygisizer on 23.03.2025.
//

import Foundation
import SwiftData

@Model
class Income {
    var name: String
    var amount: Double
    var date: Date
    var category: String?
    
    init(name: String, amount: Double, date: Date, category: String? = nil) {
        self.name = name
        self.amount = amount
        self.date = date
        self.category = category
    }
}
