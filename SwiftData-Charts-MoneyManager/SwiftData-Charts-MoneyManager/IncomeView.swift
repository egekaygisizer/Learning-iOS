//
//  IncomeView.swift
//  SwiftData-Charts-MoneyManager
//
//  Created by Ege Kaygisizer on 23.03.2025.
//

import SwiftUI
import SwiftData

struct IncomeView: View {
    @Environment(\.modelContext) var modelContext
    @Query var incomes: [Income]
    
    var body: some View {
        NavigationStack {
            List() {
                ForEach(incomes) { income in
                    VStack {
                        HStack {
                            Text(income.name)
                            
                            Spacer()
                            
                            Text(String(format: "%.2f", income.amount))
                                .foregroundStyle(Color.green)
                        }
                        
                        Text(income.date.formatted(date: .long, time: .omitted))
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                    
                }
                .onDelete {
                    deleteIncome( $0 )
                }
            }
            
            Button("Add Example") {
                addExample()
            }
        }
        .navigationTitle("Income")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    func addExample() {
        let marketExmp = Income(name: "Market", amount: 278.99, date: Date.now, category: "Market")
        let rentExmp = Income(name: "Rent", amount: 2800, date: Date.now, category: "Other")
        let salaryExmp = Income(name: "Salary", amount: 1250, date: Date.now, category: "Salary")
        
        modelContext.insert(marketExmp)
        modelContext.insert(rentExmp)
        modelContext.insert(salaryExmp)
    }
    
    func deleteIncome(_ offsets: IndexSet) {
        offsets.forEach { offset in
            let incomeToDelete = incomes[offset]
            modelContext.delete(incomeToDelete)
        }
    }
    
    func addIncome() {
        
    }
}

#Preview {
    IncomeView()
}
