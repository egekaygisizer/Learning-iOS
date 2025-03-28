//
//  RemoteImage.swift
//  Appetizers
//
//  Created by Ege Kaygisizer on 19/12/24.
//

import SwiftUI

final class ImageLoader: ObservableObject {
    
    @Published var image : Image? = nil
    
    func load(fromURLString : String) {
        NetworkManager.shared.downloadImage(fromURLString: fromURLString) { uiImage in
            guard let uiImage = uiImage else { return }
            DispatchQueue.main.async {
                self.image = Image(uiImage: uiImage)
            }
        }
    }
}

struct RemoteImage: View {
    
    var image: Image?
    
    var body: some View {
        image?.resizable() ?? Image(systemName: "fork.knife.circle").resizable()
    }
}

struct AppetizerRemoteImage: View {
    
    @StateObject var imageLoader = ImageLoader()
    let urlString: String
    
    var body: some View {
        RemoteImage(image: imageLoader.image)
            .onAppear {
                imageLoader.load(fromURLString: urlString)
            }
    }
}
