//
//  ChartView.swift
//  SwiftData-Charts-MoneyManager
//
//  Created by Ege Kaygisizer on 29.03.2025.
//

import SwiftUI
import SwiftData
import Charts

struct IncomeChartView: View {
    @Environment(\.modelContext) var modelContext
    @State var isSelectedValue: Double?
    @State var incomeCategory: String?
    
    @Query var incomes: [Income]
    
    var body: some View {
        VStack {
            //Income Chart
            VStack {
                Chart(incomes) { data in
                    SectorMark(angle: PlottableValue.value(data.category, data.amount),
                               innerRadius: .ratio(0.618),
                               angularInset: 1
                    )
                    .foregroundStyle(by: .value("Category", data.category))
                    .cornerRadius(5)
                    .opacity(incomeCategory == data.category ? 1 : 0.5)
                }.chartAngleSelection(value: $isSelectedValue)
                    .onChange(of: isSelectedValue ?? 0) { oldValue, newValue in
                        print(newValue)
                        getSelectedIncomes(angle: newValue)
                    }
                    .overlay(alignment: .center) {
                        Text(calculateTotalAmount(), format: .currency(code: "USD"))
                            .font(.body)
                            .fontWeight(.bold)
                    }
                
            }.padding().frame(height: 400)
            
            if incomeCategory == nil {
                Text("No income found for this category")
                    .foregroundStyle(.secondary)
            } else {
                ScrollView {
                    ForEach(incomes) { income in
                        if (income.category == incomeCategory) {
                            
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
                                
                                Divider()
                            }.padding(.horizontal, 25).frame(maxHeight : 140)
                        }
                    }
                }
            }
        }
        
        
    }
    
    private func getSelectedIncomes(angle: Double) {
        guard angle != 0 else { return }
        
        var startPoint = 0.0
        let calculatedRange = incomes.compactMap { income -> (String, Range<Double>) in
            let rangeEnd = startPoint + Double(income.amount)
            let tuple = (income.category, startPoint..<rangeEnd)
            startPoint = rangeEnd
            return tuple
        }
        
        if let income = calculatedRange.first(where: { $0.1.contains(angle)}) {
            incomeCategory = income.0
        }
        
    }
    
    func calculateTotalAmount() -> Double {
        guard incomeCategory != nil else { return 0.00 }
        
        var totalAmount = 0.0
        for income in incomes {
            if income.category == incomeCategory {
                totalAmount += income.amount
            }
        }
        return totalAmount
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Income.self, configurations: config)
    
    for i in 1..<10 {
        let user = Income(title: "UUID", amount: Double.random(in: 100..<10000), date: Date(), category: "food")
        container.mainContext.insert(user)
    }
    
    return IncomeChartView()
        .modelContainer(container)
}
