//
//  TimeAttackModeView.swift
//  MathRush
//
//  Created by Ege Kaygisizer on 19.04.2025.
//

import SwiftUI

struct TimeAttackModeView: View {
    @Environment(\.presentationMode) var presentationMode
    var gameDifficulties : [String] = ["Easy", "Medium", "Hard"]
    @State private var selectedDifficulty : String = "Easy"
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Time Attack Mode!")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                
                Text("Speed + Precision = Victory!\n")
                    .font(.title3)
                    .foregroundStyle(Color.yellow)
                    .fontWeight(.semibold)
                
                Text("Complete all math problems as fast as possible, every second counts!")
                    .font(.body)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                Text("Your total time determines your rank.\nFaster finishes = higher rankings")
                    .font(.body)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Picker("Difficult", selection: $selectedDifficulty) {
                    ForEach(gameDifficulties, id: \.self) { difficulty in
                        Text(difficulty)
                    }
                }.padding()
                    .pickerStyle(.palette)
                
                NavigationLink(destination: GameView(difficulty: selectedDifficulty, gameMode: "timeattack")) {
                    Text("🏁 Start the Race!")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundStyle(Color.accentColor)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color("ButtonBGColor")))
                        .padding()
                }
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Back")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundStyle(Color.accentColor)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color("ButtonBGColor")))
                        .padding()
                }
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Rectangle().fill(Color("adaptiveBackground"))).ignoresSafeArea()
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    TimeAttackModeView()
}
