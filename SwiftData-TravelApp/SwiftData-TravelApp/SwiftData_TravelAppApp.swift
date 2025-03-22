//
//  SwiftData_TravelAppApp.swift
//  SwiftData-TravelApp
//
//  Created by Ege Kaygisizer on 22.03.2025.
//

import SwiftData
import SwiftUI

@main
struct SwiftData_TravelAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self) // Create storage for Destination Object.
    }
}
