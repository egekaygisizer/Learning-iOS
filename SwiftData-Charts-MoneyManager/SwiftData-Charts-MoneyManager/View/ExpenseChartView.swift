//
//  ExpenseChartView.swift
//  SwiftData-Charts-MoneyManager
//
//  Created by Ege Kaygisizer on 30.03.2025.
//

import SwiftUI
import SwiftData
import Charts

struct ExpenseChartView: View {
    @Environment(\.modelContext) var modelContext
    @State var isSelectedValue: Double?
    @State var expenseCategory: String?
    
    @Query var expenses: [Expense]
    
    var body: some View {
        VStack {
            //Income Chart
            VStack {
                Chart(expenses) { data in
                    SectorMark(angle: PlottableValue.value(data.category, data.amount),
                               innerRadius: .ratio(0.618),
                               angularInset: 1
                    )
                    .foregroundStyle(by: .value("Category", data.category))
                    .cornerRadius(5)
                    .opacity(expenseCategory == data.category ? 1 : 0.5)
                    
                }.chartAngleSelection(value: $isSelectedValue)
                    .onChange(of: isSelectedValue ?? 0) { oldValue, newValue in
                        print(newValue)
                        gelSelectedExpenses(angle: newValue)
                    }
                    .overlay(alignment: .center) {
                        Text(calculateTotalAmount(), format: .currency(code: "USD"))
                            .font(.body)
                            .fontWeight(.bold)
                    }
                
            }.padding().frame(height: 400)
            
            if expenseCategory == nil {
                Text("No expenses found for this category")
                    .foregroundStyle(.secondary)
            } else {
                ScrollView {
                    ForEach(expenses) { expense in
                        if (expense.category == expenseCategory) {
                            
                            VStack {
                                HStack {
                                    Text(expense.title)
                                    
                                    Spacer()
                                    
                                    Text(expense.amount, format: .currency(code: "USD"))
                                        .foregroundStyle(Color.red)
                                }
                                
                                HStack {
                                    Text(expense.category)
                                        .font(.callout)
                                        .foregroundStyle(.secondary)
                                    
                                    Spacer()
                                    
                                    Text(expense.date.formatted(date: .long, time: .omitted))
                                        .font(.callout)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Divider()
                            }.padding(.horizontal, 25).frame(maxHeight : 140)
                        }
                    }
                }
            }
        }
        
        
    }
    
    private func gelSelectedExpenses(angle: Double) {
        guard angle != 0 else { return }
        
        var startPoint = 0.0
        let calculatedRange = expenses.compactMap { expense -> (String, Range<Double>) in
            let rangeEnd = startPoint + Double(expense.amount)
            let tuple = (expense.category, startPoint..<rangeEnd)
            startPoint = rangeEnd
            return tuple
        }
        
        if let expense = calculatedRange.first(where: { $0.1.contains(angle)}) {
            expenseCategory = expense.0
        }
        
    }
    
    func calculateTotalAmount() -> Double {
        guard expenseCategory != nil else { return 0.00 }
        
        var totalAmount = 0.0
        for expense in expenses {
            if expense.category == expenseCategory {
                totalAmount += expense.amount
            }
        }
        return totalAmount
    }
}

#Preview {
    ExpenseChartView()
}
