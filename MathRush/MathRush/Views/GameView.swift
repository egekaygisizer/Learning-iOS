//
//  GameView.swift
//  MathRush
//
//  Created by Ege Kaygisizer on 19.04.2025.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel = GameViewModel()
    var difficulty: String
    var gameMode: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            VStack {
                if !viewModel.isGameOver {
                    if viewModel.isStarted {
                        
                        VStack(spacing: 24) {
                            if viewModel.mode == "classic" {
                                Text("Best Score: \(viewModel.highScore)")
                            } else {
                                Text("Best Time: \(String(format: "%.2fs", viewModel.bestTime))")
                            }
                            
                            HStack {
                                if viewModel.mode == "classic" {
                                    Text("Score: \(viewModel.score)")
                                } else {
                                    Text("⏱ \(viewModel.elapsedTimeFormatted)")
                                }
                                Spacer()
                                if viewModel.mode == "classic" {
                                    Text("⏱ \(viewModel.timeRemaining)s")
                                } else {
                                    Text("❓\(viewModel.questionsRemaining) left")
                                }
                            }
                            .font(.headline)
                            .padding()

                            Text(viewModel.currentQuestion)
                                .font(.largeTitle)
                                .bold()

                            VStack(spacing: 12) {
                                ForEach(viewModel.answerChoices, id: \.self) { choice in
                                    Button(action: {
                                        viewModel.checkAnswer(choice, difficulty: difficulty)
                                    }) {
                                        Text("\(choice)")
                                            .font(.title2)
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color("ButtonBGColor"))
                                            .cornerRadius(12)
                                    }
                                }
                            }
                            .padding()
                        }
                        .padding()
                    } else {
                        Text("Are you ready?")
                            .font(.largeTitle)
                            .foregroundStyle(Color.accentColor)
                            .bold()

                        Button {
                            withAnimation {
                                viewModel.isStarted = true
                            }
                            viewModel.startGame(mode: gameMode, difficulty: difficulty)
                        } label: {
                            Text("Yes!")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .padding()
                                .foregroundStyle(Color.accentColor)
                                .background(RoundedRectangle(cornerRadius: 12).fill(Color("ButtonBGColor")))
                                .padding()
                        }
                    }
                } else {
                    VStack {
                        if viewModel.mode == "classic" {
                            Text("Your score is : \(viewModel.score)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding()

                            if viewModel.score > viewModel.highScore {
                                Text("Congrats! You beat your high score!")
                                    .font(.title3)
                                    .fontWeight(.bold)
                            } else {
                                Text("Your high score is : \(viewModel.highScore)")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                        } else {
                            if viewModel.questionsRemaining > 0 {
                                Text("Oops! You made a mistake 😢")
                                    .font(.title3)
                                    .foregroundStyle(.red)
                            } else {
                                Text("You finished in \(viewModel.elapsedTimeFormatted)")
                                    .font(.title2)
                                    .bold()
                                
                                if viewModel.bestTime > 0 {
                                    Text("Best Time: \(String(format: "%.2fs", viewModel.bestTime))")
                                        .font(.title3)
                                        .foregroundStyle(.secondary)
                                    
                                    if viewModel.elapsedTimeFormatted == String(format: "%.2fs", viewModel.bestTime) {
                                        Text("🎉 New Record!")
                                            .font(.title3)
                                            .foregroundStyle(.green)
                                            .bold()
                                    }
                                }
                            }
                            
                        }

                        Button {
                            withAnimation {
                                viewModel.isStarted = true
                                viewModel.isGameOver = false
                            }
                            viewModel.startGame(mode: gameMode, difficulty: difficulty)
                        } label: {
                            Text("Play Again!")
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
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Rectangle().fill(Color("adaptiveBackground")))
            .ignoresSafeArea()
        }
        .overlay(alignment: .topLeading) {
            Image(systemName: "chevron.left")
                .resizable()
                .scaledToFit()
                .padding()
                .frame(width: 50, height: 50)
                .background(Circle().fill(Color("ButtonBGColor").opacity(0.5)))
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()

        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    GameView(difficulty: "easy", gameMode: "classic")
}
