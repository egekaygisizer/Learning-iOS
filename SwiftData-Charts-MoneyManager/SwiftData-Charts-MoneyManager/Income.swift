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
    var title: String
    var amount: Double
    var date: Date
    var category: String
    
    init(title: String, amount: Double, date: Date, category: String) {
        self.title = title
        self.amount = amount
        self.date = date
        self.category = category
    }
}
