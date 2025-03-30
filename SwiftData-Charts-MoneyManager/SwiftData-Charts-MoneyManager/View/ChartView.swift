//
//  ChartView.swift
//  SwiftData-Charts-MoneyManager
//
//  Created by Ege Kaygisizer on 30.03.2025.
//

import SwiftUI

struct ChartView: View {
    @State var selectedTab: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<2) { index in
                    Button {
                        selectedTab = index
                    }label: {
                        VStack {
                            Text(tabTitle(index: index))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(selectedTab == index ? Color.green : .secondary)
                                .background()
                        }
                    }
                }
            }
            
            TabView(selection: $selectedTab) {
                IncomeChartView()
                    .tag(0)
                
                ExpenseChartView()
                    .tag(1)
            }.tabViewStyle(PageTabViewStyle()) // Slide to screen
        }
    }
    
    func tabTitle(index: Int ) -> String {
        switch index {
        case 0:
            return "Income"
        case 1:
            return "Expense"
        default:
           return "Charts"
        }
    }
}

#Preview {
    ChartView()
}
