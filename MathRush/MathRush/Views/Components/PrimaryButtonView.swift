//
//  PrimaryButtonView.swift
//  MathRush
//
//  Created by Ege Kaygisizer on 23.04.2025.
//

import SwiftUI

struct PrimaryButtonView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.semibold)
            .padding()
            .foregroundStyle(Color.accentColor)
            .background(RoundedRectangle(cornerRadius: 12).fill(Color("ButtonBGColor")))
    }
}

#Preview {
    PrimaryButtonView(text: "test")
}
