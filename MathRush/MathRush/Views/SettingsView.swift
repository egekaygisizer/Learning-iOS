//
//  SettingsView.swift
//  MathRush
//
//  Created by Ege Kaygisizer on 22.04.2025.
//

import SwiftUI

enum AppTheme: String, CaseIterable {
    case system, light, dark
}

struct SettingsView: View {
    @AppStorage("appTheme") private var appTheme: String = AppTheme.system.rawValue
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("HighScore") private var highScore: Int = 0
    @AppStorage("BestTime") private var bestTime: Double = 0.0

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                VStack(spacing: 5) {
                    // Tema Seçimi
                    HStack {
                        Text("App Theme:")
                            .font(.headline)
                        
                        Picker("App Theme", selection: $appTheme) {
                            Text("System").tag(AppTheme.system.rawValue)
                            Text("Light").tag(AppTheme.light.rawValue)
                            Text("Dark").tag(AppTheme.dark.rawValue)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding(5)
                    
                    HStack {
                        Text("Reset Classic High Score:\n \(highScore) points")
                            .font(.headline)
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        Button {
                            UserDefaults.standard.set(0, forKey: "HighScore")
                        }label: {
                            Text("Reset")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .padding()
                                .foregroundStyle(Color.accentColor)
                                .background(RoundedRectangle(cornerRadius: 12).fill(Color("ButtonBGColor")))
                        }
                    }
                    .padding(5)
                    
                    HStack {
                        Text("Reset Time Attack Best Time:\n \(String(format: "%.2f", bestTime)) seconds")
                            .font(.headline)
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        Button {
                            UserDefaults.standard.set(0, forKey: "BestTime")
                        }label: {
                            Text("Reset")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .padding()
                                .foregroundStyle(Color.accentColor)
                                .background(RoundedRectangle(cornerRadius: 12).fill(Color("ButtonBGColor")))
                        }
                    }
                    .padding(5)
                    
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
                    
                    VStack() {
                        Text("Version 1.1")
                            .font(.callout)
                            .foregroundStyle(Color.secondary)
                        Link("Terms & Conditions", destination: URL(string: "https://github.com/egekaygisizer/Math-Rush/blob/main/terms.md")!)
                            .font(.callout)
                            .foregroundStyle(Color.secondary)
                        Link("Privacy Policy", destination: URL(string: "https://github.com/egekaygisizer/Math-Rush/blob/main/privacy.md")!)
                            .font(.callout)
                            .foregroundStyle(Color.secondary)
                        
                    }
                    
                }.padding()
            }.padding(.top, 100)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("adaptiveBackground"))
            .ignoresSafeArea()
        }.navigationBarBackButtonHidden()
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    SettingsView()
}
