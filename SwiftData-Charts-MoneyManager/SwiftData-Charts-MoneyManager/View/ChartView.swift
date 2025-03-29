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
    var dummyData = [
        Income(title: "Maaş", amount: 20, date: Date(), category: "Maaş"),
        Income(title: "Freelance Proje", amount: 30, date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, category: "Freelance"),
        Income(title: "Kira Geliri", amount: 200, date: Calendar.current.date(byAdding: .day, value: -10, to: Date())!, category: "Yatırım"),
        Income(title: "Hisse Senedi", amount: 50, date: Calendar.current.date(byAdding: .day, value: -20, to: Date())!, category: "Yatırım"),
        Income(title: "Dijital Ürün Satışı", amount: 120, date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, category: "E-Ticaret")
    ]
    @Environment(\.modelContext) var modelContext
    @State var incomes = [Income]
    @State var isSelectedValue: Double?
    @State var incomeCategory: String?
    
    
    var body: some View {
        ScrollView {
            //Income Chart
            VStack {
                Text("Income pie chart")
                
                Chart(dummyData) { data in
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
                    .onChange(of: isSelectedValue) { oldValue, newValue in
                        print(newValue ?? 0)
                    }
                    
                
            }.padding()
            .frame(height: 400)
            
            
        }.padding()
    }
    
    private func getSelectedIncomes(angle: Double?) {
        guard angle != 0 else { return }
        
        var startPoint = 0.0
        let calculatedRange = dummyData.compactMap { income -> (String, Range<Double>) in
            let rangeEnd = startPoint + Double(income.amount)
            let tuple = (income.category, startPoint..<rangeEnd)
            startPoint = rangeEnd
            return tuple
        }
        
        if let income = calculatedRange.first(where: { $0.1.contains(angle ?? 0)}) {
            incomeCategory = income.0
        }
        
        var fetchDescriptor = FetchDescriptor<Income>(
            predicate: #Predicate<Income> { income in
                income.category == incomeCategory
            }
        )
        
        do {
            try modelContext.fetch(fetchDescriptor)
        } catch(let error) {
            print(error)
        }
    }
}

#Preview {
    ChartView(incomeCategory: "", incomes: [])
}
