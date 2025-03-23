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
    @State var isShowAddIncomeView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(incomes) { income in
                        VStack {
                            HStack {
                                Text(income.title)
                                
                                Spacer()
                                
                                Text(income.amount, format: .currency(code: "USD"))
                                    .foregroundStyle(Color.green)
                                     }
                                     
                                     HStack {
                                    Text(income.category)
                                        .font(.callout)
                                        .foregroundStyle(.secondary)
                                    
                                    Spacer()
                                    
                                    Text(income.date.formatted(date: .long, time: .omitted))
                                    .font(.callout)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }.onDelete {
                        deleteIncome( $0 )
                    }
                }
             
                HStack {
                    Button("Add", systemImage: "plus") {
                        isShowAddIncomeView.toggle()
                    }
                    
                    Button("+ Exmple") {
                        addExample()
                    }
                }
                
            }
            .navigationTitle("Income")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isShowAddIncomeView) {
                AddIncomeView(modelContext: _modelContext)
            }
            
            
        }
        
        
    }
    
    func addExample() {
        let marketExmp = Income(title: "Market", amount: 278.99, date: Date.now, category: "Market")
        let rentExmp = Income(title: "Rent", amount: 2800, date: Date.now, category: "Other")
        let salaryExmp = Income(title: "Salary", amount: 1250, date: Date.now, category: "Salary")
        
        modelContext.insert(marketExmp)
        modelContext.insert(rentExmp)
        modelContext.insert(salaryExmp)
        
        do {
            try modelContext.save()  // Değişiklikleri kaydedin
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    func deleteIncome(_ offsets: IndexSet) {
        offsets.forEach { offset in
            let incomeToDelete = incomes[offset]
            modelContext.delete(incomeToDelete)
        }
    }
    
}

#Preview {
    IncomeView()
}
