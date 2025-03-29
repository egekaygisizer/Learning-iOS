//
//  ContentView.swift
//  SwiftData-Charts-MoneyManager
//
//  Created by Ege Kaygisizer on 23.03.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var incomeSortOption: SortDescriptor = SortDescriptor(\Income.date, order: .reverse)
    @State var expenseSortOption: SortDescriptor = SortDescriptor(\Expense.date, order: .reverse)
    @State var searchString: String = ""
    @State var isShowAddIncomeView = false
    @State var isShowAddExpenseView = false
    
    var body: some View {
        NavigationStack {
            TabView {
                NavigationView {
                    IncomeView(sort: incomeSortOption, searchString: searchString, isShowAddIncomeView: $isShowAddIncomeView)
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
                                    Picker("Sort by", selection: $incomeSortOption) {
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
                
                NavigationView {
                    ExpenseView(sort: expenseSortOption, searchString: searchString, isShowAddExpenseView: $isShowAddExpenseView)
                        .searchable(text: $searchString)
                        .navigationTitle("Expense")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItemGroup(placement: .topBarTrailing) {
                                Button(action: {
                                    isShowAddExpenseView.toggle()
                                }) {
                                    Image(systemName: "plus")
                                }
                                
                                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                                    Picker("Sort by", selection: $expenseSortOption) {
                                        Text("Date ↓").tag(SortDescriptor(\Expense.date, order: .reverse))
                                        Text("Date ↑").tag(SortDescriptor(\Expense.date))
                                        Text("Amount ↓").tag(SortDescriptor(\Expense.amount, order: .reverse))
                                        Text("Amount ↑").tag(SortDescriptor(\Expense.amount))
                                        Text("Title A-Z").tag(SortDescriptor(\Expense.title, order: .forward))
                                        Text("Title Z-A").tag(SortDescriptor(\Expense.title, order: .reverse))
                                    }
                                }
                            }
                        }
                }
                .tabItem {
                    Label("Expense", systemImage: "dollarsign")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
