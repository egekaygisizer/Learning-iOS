//
//  ExpenseView.swift
//  SwiftData-Charts-MoneyManager
//
//  Created by Ege Kaygisizer on 29.03.2025.
//

import SwiftUI
import SwiftData

struct ExpenseView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    @Binding var isShowAddExpenseView: Bool
    
    init(sort: SortDescriptor<Expense>, searchString: String, isShowAddExpenseView: Binding<Bool>) {
        _isShowAddExpenseView = isShowAddExpenseView
        
        _expenses = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.title.localizedStandardContains(searchString)
            }
        }, sort: [sort])
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                ForEach(expenses) { expenses in
                    VStack {
                        HStack {
                            Text(expenses.title)
                            
                            Spacer()
                            
                            Text(expenses.amount, format: .currency(code: "USD"))
                                .foregroundStyle(Color.red)
                        }
                        
                        HStack {
                            Text(expenses.category)
                                .font(.callout)
                                .foregroundStyle(.secondary)
                            
                            Spacer()
                            
                            Text(expenses.date.formatted(date: .long, time: .omitted))
                                .font(.callout)
                                .foregroundStyle(.secondary)
                        }
                    }
                }.onDelete {
                    deleteExpense( $0 )
                }
            }
            
        }
        .padding()
        .sheet(isPresented: $isShowAddExpenseView) {
            AddExpenseView(modelContext: _modelContext)
        }
        
        
        
    }
    
    func deleteExpense(_ offsets: IndexSet) {
        offsets.forEach { offset in
            let expenseToDelete = expenses[offset]
            modelContext.delete(expenseToDelete)
        }
        
        do {
            try modelContext.save()  // Save changes do swiftdata
        } catch {
            print("Error saving context: \(error)")
        }
    }
}

//#Preview {
//    ExpenseView(sort: SortDescriptor(Expense.title), searchString: "", isShowAddExpenseView: .constant(false))
//}
