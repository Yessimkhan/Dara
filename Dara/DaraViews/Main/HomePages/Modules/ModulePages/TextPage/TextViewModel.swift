//
//  TextViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 18.04.2024.
//

import Foundation
import SwiftUI

final class TextViewModel: ObservableObject {
    
    let data: Content
    @Published var imagesArray: [Image] = []
    @Published var isLoading: Bool = false
    @Published var image: Image?
    @Published var audioData: Data?
    @AppStorage("user_id") var userId: String?
    
    init(data: Content) {
        self.data = data
        
        if let imageData = data.image {
            isLoading = true
            if imageData != "" {
                HomeRepository().downloadImage(from: imageData) { image in
                    self.isLoading = false
                    self.image = image
                }
            }
        }
        
        guard let audio = data.audio else {return}
        HomeRepository().downloadAudio(from: audio) { data in
            self.audioData = data
        }
    }
}

