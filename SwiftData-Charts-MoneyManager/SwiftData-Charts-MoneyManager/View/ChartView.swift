//
//  ChartView.swift
//  SwiftData-Charts-MoneyManager
//
//  Created by Ege Kaygisizer on 29.03.2025.
//

import SwiftUI
import SwiftData
import Charts

struct ChartView: View {
    @Environment(\.modelContext) var modelContext
    @State var isSelectedValue: Double?
    @State var incomeCategory: String?
    
    @Query var incomes: [Income]
    
    var body: some View {
        VStack {
            //Income Chart
            VStack {
                Text("Income pie chart")
                
                Chart(incomes) { data in
                    SectorMark(angle: PlottableValue.value(data.category, data.amount),
                               innerRadius: .ratio(0.618),
                               angularInset: 1
                    )
                    .annotation(position: .overlay) {
                        Text(data.amount, format: .currency(code: "USD"))
                            .font(.caption)
                            .bold()
                    }
                    .foregroundStyle(by: .value("Category", data.category))
                    .cornerRadius(5)
                }.chartAngleSelection(value: $isSelectedValue)
                    .onChange(of: isSelectedValue ?? 0) { oldValue, newValue in
                        print(newValue)
                        getSelectedIncomes(angle: newValue)
                    }
                
            }.padding()
                .frame(height: 400)
            
            if incomes.isEmpty {
                Text("No income found for this category")
                    .foregroundStyle(.secondary)
            } else {
                List {
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
                            }
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
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Income.self, configurations: config)
    
    for i in 1..<10 {
        let user = Income(title: "UUID", amount: Double.random(in: 100..<10000), date: Date(), category: "food")
        container.mainContext.insert(user)
    }
    
    return ChartView()
        .modelContainer(container)
}
