//
//  FrameworkGridViewModel.swift
//  Apple-Frameworks
//
//  Created by Ege Kaygisizer on 12/12/24.
//

import SwiftUI

class FrameworkGridViewModel : ObservableObject {
    
    var selectedFramework : Framework? {
        didSet {isShowingDetailView = true}
    }
    @Published var isShowingDetailView = false
    
    let columns : [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())] // we made 3 column.
}
