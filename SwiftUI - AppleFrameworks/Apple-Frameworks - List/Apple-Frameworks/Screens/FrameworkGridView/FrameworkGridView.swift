//
//  FrameworkGridView.swift
//  Apple-Frameworks
//
//  Created by Ege Kaygisizer on 11/12/24.
//

import SwiftUI

struct FrameworkGridView: View {
    
    @StateObject var viewModel = FrameworkGridViewModel()

    
    var body: some View {
        NavigationView() {
            List {
                ForEach(MockData.frameworks) { framework in
                    NavigationLink(destination: FrameworkDetailView(framework: framework,
                                                                    isShowingDetailView: $viewModel.isShowingDetailView)) {
                        FrameworkTitleView(framework: framework)
                    }
                }
            }
            .navigationTitle("🍎 Frameworks")
        }
    }
}

#Preview {
    FrameworkGridView()
        .preferredColorScheme(.dark)
}



