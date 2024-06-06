//
//  TextViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 18.04.2024.
//

import Foundation
import SwiftUI
import SwiftfulRouting

final class TextViewModel: ObservableObject {
    
    let router: AnyRouter
    let data: Content
    @Published var imagesArray: [Image] = []
    @Published var isLoadingImage: Bool = false
    @Published var image: Image?
    @Published var audioData: Data?
    @AppStorage("user_id") var userId: String?
    
    init(router: AnyRouter, data: Content) {
        self.router = router
        self.data = data
        
        if let imageData = data.image {
            if imageData != "" {
                image = Image(systemName: "star.fill")
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

