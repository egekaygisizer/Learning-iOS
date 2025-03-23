//
//  DestinationListingView.swift
//  SwiftData-TravelApp
//
//  Created by Ege Kaygisizer on 22.03.2025.
//

import SwiftUI
import SwiftData

struct DestinationListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query var destinations: [Destination]
    
    var body: some View {
        VStack {
            List {
                ForEach(destinations) { destination in
                    NavigationLink(value: destination)  {
                        VStack(alignment: .leading) {
                            Text(destination.name)
                                .font(.headline)
                            
                            Text(destination.date.formatted(date: .long, time: .shortened))
                        }
                    }
                }
                .onDelete {
                    deleteDestinations( $0 )
                }
            }
        }
    }
    
    init (sort: SortDescriptor<Destination>, searchString: String) {
//        let date = Date.now
        
        _destinations = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.name.localizedStandardContains(searchString)
            }
//            $0.priority >= 2
//            $0.date > now
        }, sort: [sort])
    }
    
    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Destination.name), searchString: "")
}
