//
//  AddExpenseView.swift
//  SwiftData-Charts-MoneyManager
//
//  Created by Ege Kaygisizer on 29.03.2025.
//

import SwiftUI

struct AddExpenseView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    @State private var amount: Double = 0.0
    @State private var category: String = "Other"
    @State private var date: Date = Date.now
    
    var body: some View {
        Form {
            Section("Add Expense") {
                TextField("Expense title", text: $title)
                
                TextField("Expense amount", value: $amount, format: .number)
                    .keyboardType(.decimalPad)
                    
                
                DatePicker("Expense date", selection: $date, displayedComponents: .date)
            }
            
            Section("Category") {
                Picker("Category", selection: $category) {
                    Text("Market").tag("Market")
                    Text("Rent").tag("Rent")
                    Text("Tax").tag("Tax")
                    Text("Bills").tag("Bills")
                    Text("Technology").tag("Technology")
                    Text("Other").tag("Other")
                }.pickerStyle(.menu)
            }

            
            Button("Save") {
                saveExpense()
                dismiss()
            }
        }
        
    }
    
    func saveExpense() {
        let newExpense = Expense(title: title, amount: amount, date: date, category: category)
        modelContext.insert(newExpense)
    }
}

#Preview {
    AddExpenseView()
}
