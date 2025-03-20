//
//  FrameworkTitleView.swift
//  Apple-Frameworks
//
//  Created by Ege Kaygisizer on 13/12/24.
//

import SwiftUI

struct FrameworkTitleView: View {
    
    let framework : Framework
    
    var body : some View {
        HStack {
            Image(framework.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 75, height: 75)
            Text(framework.name)
                .font(.title2)
                .fontWeight(.semibold)
                .scaledToFit()
                .minimumScaleFactor(0.65)
                .padding()
        }

    }
}

#Preview {
    FrameworkTitleView(framework: MockData.sampleFramework)
}
