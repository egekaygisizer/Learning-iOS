//
//  ContentView.swift
//  SwiftData-Charts-MoneyManager
//
//  Created by Ege Kaygisizer on 23.03.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var sortOption: SortDescriptor = SortDescriptor(\Income.date, order: .reverse)
    @State var searchString: String = ""
    @State var isShowAddIncomeView = false
    
    var body: some View {
        NavigationStack {
            TabView {
                NavigationView {
                    IncomeView(sort: sortOption, searchString: searchString, isShowAddIncomeView: $isShowAddIncomeView)
                        .searchable(text: $searchString)
                        .navigationTitle("Income")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItemGroup(placement: .topBarTrailing) {
                                Button(action: {
                                    isShowAddIncomeView.toggle()
                                }) {
                                    Image(systemName: "plus")
                                }
                                
                                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                                    Picker("Sort by", selection: $sortOption) {
                                        Text("Date ↓").tag(SortDescriptor(\Income.date, order: .reverse))
                                        Text("Date ↑").tag(SortDescriptor(\Income.date))
                                        Text("Amount ↓").tag(SortDescriptor(\Income.amount, order: .reverse))
                                        Text("Amount ↑").tag(SortDescriptor(\Income.amount))
                                        Text("Title A-Z").tag(SortDescriptor(\Income.title, order: .forward))
                                        Text("Title Z-A").tag(SortDescriptor(\Income.title, order: .reverse))
                                    }
                                }
                            }
                        }
                }
                .tabItem {
                    Label("Income", systemImage: "dollarsign")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
