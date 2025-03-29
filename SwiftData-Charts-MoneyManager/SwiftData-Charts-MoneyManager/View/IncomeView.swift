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
    @Binding var isShowAddIncomeView: Bool
    
    init(sort: SortDescriptor<Income>, searchString: String, isShowAddIncomeView: Binding<Bool>) {
        _isShowAddIncomeView = isShowAddIncomeView
        
        _incomes = Query(filter: #Predicate {
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
            
        }
        .padding()
        .sheet(isPresented: $isShowAddIncomeView) {
            AddIncomeView(modelContext: _modelContext)
        }
        
        
        
    }
    
    
    func deleteIncome(_ offsets: IndexSet) {
        offsets.forEach { offset in
            let incomeToDelete = incomes[offset]
            modelContext.delete(incomeToDelete)
        }
        
        do {
            try modelContext.save()  // Save changes do swiftdata
        } catch {
            print("Error saving context: \(error)")
        }
    }
}


#Preview {
    IncomeView(sort: SortDescriptor(\Income.title), searchString: "", isShowAddIncomeView: .constant(false))
}
