//
//  AFButton.swift
//  Apple-Frameworks
//
//  Created by Ege Kaygisizer on 12/12/24.
//

import SwiftUI

struct AFButton: View {
    
    var title : String
    
    var body: some View {
        
        Text(title)
            .font(.title2)
            .fontWeight(.semibold)
            .frame(width: 280, height: 60)
            .background(Color.red)
            .foregroundStyle(Color.white)
            .cornerRadius(10)
    }
}

#Preview {
    AFButton(title: "Learn More")
}
