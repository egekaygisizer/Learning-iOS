//
//  MathRushApp.swift
//  MathRush
//
//  Created by Ege Kaygisizer on 19.04.2025.
//

import SwiftUI

@main
struct MathRushApp: App {
    @AppStorage("appTheme") var appTheme: String = AppTheme.system.rawValue
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .preferredColorScheme(currentColorScheme())
        }
    }
    
    func currentColorScheme() -> ColorScheme? {
        switch AppTheme(rawValue: appTheme) ?? .system {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}
