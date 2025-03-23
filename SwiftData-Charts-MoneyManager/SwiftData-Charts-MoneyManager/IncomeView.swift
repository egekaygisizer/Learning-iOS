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
    @State var sortOption: SortOption = .dateDescending
    @State var incomes: [Income]
    @State var isShowAddIncomeView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                HStack {
                    Picker("Sort by", selection: $sortOption) {
                        Text("Date ↓").tag(SortOption.dateDescending)
                        Text("Date ↑").tag(SortOption.dateAscending)
                        Text("Amount ↓").tag(SortOption.amountDescending)
                        Text("Amount ↑").tag(SortOption.amountAscending)
                        Text("Title A-Z").tag(SortOption.titleAscending)
                        Text("Title Z-A").tag(SortOption.titleDescending)
                    }
                    Spacer()
                    
                    Button("Add Income", systemImage: "plus") {
                        isShowAddIncomeView.toggle()
                    }.buttonStyle(.bordered)
                }
                
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
             
                
                Spacer()
            }
            .navigationTitle("Income")
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: sortOption) {
                fetchAndSortIncome()
            }
            .onAppear {
                fetchAndSortIncome()
            }
            .sheet(isPresented: $isShowAddIncomeView) {
                AddIncomeView(modelContext: _modelContext, saveAndFetchAction: fetchAndSortIncome)
            }
            
        }
        
    }
    
    func fetchAndSortIncome() {
        let descriptor: FetchDescriptor<Income> // We can fetch and sort data dynamically by using FetchDescriptor
        
        switch sortOption {
        case .dateDescending:
            descriptor = FetchDescriptor<Income>(sortBy: [SortDescriptor(\.date, order: .reverse)])
        case .dateAscending:
            descriptor = FetchDescriptor<Income>(sortBy: [SortDescriptor(\.date, order: .forward)])
        case .amountDescending:
            descriptor = FetchDescriptor<Income>(sortBy: [SortDescriptor(\.amount, order: .reverse)])
        case .amountAscending:
            descriptor = FetchDescriptor<Income>(sortBy: [SortDescriptor(\.amount, order: .forward)])
        case .titleAscending:
            descriptor = FetchDescriptor<Income>(sortBy: [SortDescriptor(\.title, order: .forward)])
        case .titleDescending:
            descriptor = FetchDescriptor<Income>(sortBy: [SortDescriptor(\.title, order: .reverse)])
        }
        
        do {
            incomes = try modelContext.fetch(descriptor)
        } catch {
            print("Error fetching incomes: \(error)")
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
            try modelContext.save() // Save changes do swiftdata
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    
    func deleteIncome(_ offsets: IndexSet) {
        offsets.forEach { offset in
            let incomeToDelete = incomes[offset]
            modelContext.delete(incomeToDelete)
        }
        
        fetchAndSortIncome()
        
        do {
            try modelContext.save()  // Save changes do swiftdata
        } catch {
            print("Error saving context: \(error)")
        }
    }
}

enum SortOption {
    case dateDescending
    case dateAscending
    case amountDescending
    case amountAscending
    case titleAscending
    case titleDescending
}

#Preview {
    IncomeView(incomes: [])
}
