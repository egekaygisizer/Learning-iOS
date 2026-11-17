//
//  ContentView.swift
//  MathRush
//
//  Created by Ege Kaygisizer on 19.04.2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image("transparentLogo")
                    .resizable().scaledToFit()
                    .frame(width: 150, height: 120)
                
                Text("Math Rush!")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                
                NavigationLink(destination: ModeSelectionView()) {
                    PrimaryButtonView(text: "Play Game")
                }
               
                NavigationLink(destination: SettingsView()) {
                    PrimaryButtonView(text: "Settings")
                }

            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Rectangle().fill(Color("adaptiveBackground"))).ignoresSafeArea()
        }
        

    }
}

#Preview {
    HomeView()
}
