//
//  CardViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 27.05.2024.
//

import Foundation
import SwiftUI

final class CardViewModel: ObservableObject {
    
    let data: Content
    @Published var isLoadingImage: Bool = false
    @Published var image: Image?
    @Published var audioData: Data?
    @AppStorage("user_id") var userId: String?
    
    init(data: Content) {
        self.data = data
        
        if let imageData = data.image {
            if imageData != "" {
                isLoadingImage = true
                HomeRepository().downloadImage(from: imageData) { image in
                    self.isLoadingImage = false
                    self.image = image
                }
            }
        }
        
        if let audioData = data.audio {
            if audioData != "" {
                HomeRepository().downloadAudio(from: audioData) { data in
                    self.audioData = data
                }
            }
        }
    }
}
