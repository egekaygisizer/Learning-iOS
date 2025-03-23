//
//  ContentView.swift
//  SwiftData-Charts-MoneyManager
//
//  Created by Ege Kaygisizer on 23.03.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            IncomeView(incomes: [])
                .tabItem {
                    Label("Income", systemImage: "dollarsign")
                }
        }
    }
}

#Preview {
    ContentView()
}
