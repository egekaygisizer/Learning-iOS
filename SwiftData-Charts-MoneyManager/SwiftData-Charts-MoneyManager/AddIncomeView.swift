//
//  AddIncomeView.swift
//  SwiftData-Charts-MoneyManager
//
//  Created by Ege Kaygisizer on 23.03.2025.
//

import SwiftUI
import SwiftData

struct AddIncomeView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    var saveAndFetchAction: () -> Void = {}
    @State private var title: String = ""
    @State private var amount: Double = 0.0
    @State private var category: String = "Other"
    @State private var date: Date = Date.now
    
    var body: some View {
        Form {
            Section("Add Income") {
                TextField("Income title", text: $title)
                
                TextField("Income amount", value: $amount, format: .number)
                    .keyboardType(.decimalPad)
                    
                
                DatePicker("Income date", selection: $date, displayedComponents: .date)
            }
            
            Section("Category") {
                Picker("Category", selection: $category) {
                    
                    Text("Salary").tag("Salary")
                    Text("Investments").tag("Investments")
                    Text("Rent").tag("Rent")
                    Text("Government").tag("Government")
                    Text("Gift").tag("Gift")
                    Text("Other").tag("Other")
                }.pickerStyle(.menu)
            }

            
            Button("Save") {
                saveIncome()
                dismiss()
            }
        }
        
    }
    
    func saveIncome() {
        let newIncome = Income(title: title, amount: amount, date: date, category: category)
        modelContext.insert(newIncome)
        saveAndFetchAction()
    }
    
}

#Preview {
    AddIncomeView()
}
