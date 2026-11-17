//
//  ClassicModeView.swift
//  MathRush
//
//  Created by Ege Kaygisizer on 19.04.2025.
//

import SwiftUI

struct ClassicModeView: View {
        @Environment(\.presentationMode) var presentationMode
    var gameDifficulties : [String] = ["Easy", "Medium", "Hard"]
    @State private var selectedDifficulty : String = "Easy"
    @State var gameVM = GameViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Classic Mode!")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                
                Text("Race Against Time!\n")
                    .font(.title3)
                    .foregroundStyle(Color.orange)
                    .fontWeight(.semibold)
                
                Text("Solve as many math problems (addition, subtraction, multiplication, division) as possible before time runs out.\nTime: 30 seconds")
                    .font(.body)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                Text("✅ +5 points per correct answer \n❌ -2 points per wrong answer")
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
                    
                
                NavigationLink(destination: GameView(viewModel:gameVM, difficulty: selectedDifficulty, gameMode: "classic")) {
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
    ClassicModeView()
}
