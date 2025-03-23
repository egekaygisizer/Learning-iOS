//
//  EditDestinationView.swift
//  SwiftData-TravelApp
//
//  Created by Ege Kaygisizer on 22.03.2025.
//

import SwiftUI
import SwiftData

struct EditDestinationView: View {
    @Bindable var destination: Destination
    @State private var newSightName = ""
    
    var body: some View {
        Form {
            TextField("Name", text: $destination.name)
            TextField("Details", text: $destination.details)
            DatePicker("Date", selection: $destination.date)
            
            Section("Priorty") {
                Picker("Priortiyu", selection: $destination.priority) {
                    Text("Meh").tag(1)
                    Text("Maybe").tag(2)
                    Text("Must").tag(3)
                }.pickerStyle(.segmented)
            }
            
            Section("Sights") {
                ForEach(destination.sights) { sight in
                    Text(sight.name)
                }
                
                HStack {
                    TextField("Add a new sight in \(destination.name)", text: $newSightName)
                    
                    Button("Add", action: addSight)
                }
            }
        }
        .navigationTitle("Edit Destination")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addSight() {
        guard newSightName.isEmpty == false else { return }
        
        withAnimation {
            let sights = Sight(name: newSightName)
            destination.sights.append(sights)
            newSightName = ""
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Destination.self, configurations: config)
        let example = Destination(name: "Example Destination", details: "Example details go here and so on...")
        return EditDestinationView(destination: example)
                .modelContainer(container)
    } catch {
        fatalError(error.localizedDescription)
    }
}
