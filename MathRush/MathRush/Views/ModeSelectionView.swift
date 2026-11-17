//
//  ModeSelectionView.swift
//  MathRush
//
//  Created by Ege Kaygisizer on 19.04.2025.
//

import SwiftUI

struct ModeSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var classicHighScore: Int = UserDefaults.standard.integer(forKey: "classicHighScore")
    @State var bestTime: TimeInterval = UserDefaults.standard.double(forKey: "BestTime")
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Select Mode!")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                
                
                VStack(spacing: 15) {
                    
                    NavigationLink(destination: ClassicModeView()) {
                        
                        HStack {
                            Text("Classic Mode")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .padding()
                                .foregroundStyle(Color.accentColor)
                            
                            Spacer()
                            
                            Text("Solve maximum questions in 60 seconds")
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundStyle(Color.primary)
                                .multilineTextAlignment(.center)
                        }
                        
                    }.padding(6)
                        .frame(width: UIScreen.main.bounds.width - 40)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color("ButtonBGColor")))
                    
                    NavigationLink(destination: TimeAttackModeView()) {
                        HStack {
                            Text("Time Attack")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .padding()
                                .foregroundStyle(Color.accentColor)
                            
                            Spacer()
                            
                            Text("Try to finish 10 questions as soon as possible.")
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundStyle(Color.primary)
                                .multilineTextAlignment(.center)
                        }
                        
                    }.padding(6)
                        .frame(width: UIScreen.main.bounds.width - 40)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color("ButtonBGColor")))
                    
                }.padding()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Back")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundStyle(Color.accentColor)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color("ButtonBGColor")))
                        .padding(40)
                }
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Rectangle().fill(Color("adaptiveBackground"))).ignoresSafeArea()
        }.navigationBarBackButtonHidden()
        
        
    }
}

#Preview {
    ModeSelectionView()
}
