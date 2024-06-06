//
//  TrueFalseViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 18.04.2024.
//

import Foundation
import SwiftUI
import SwiftfulRouting

final class TrueFalseViewModel: ObservableObject {
    
    let router: AnyRouter
    let data: Content
    @Published var isLoadingImage: Bool = false
    @Published var image: Image? = nil
    @Published var audioData: Data? = nil
    @AppStorage("user_id") var userId: String?
    @Published var shuffledVariants: [String] = []
    @Published var variantsDisabled: Bool = false

    init(router: AnyRouter, data: Content) {
        self.router = router
        self.data = data
        self.shuffledVariants = data.variants?.shuffled() ?? []
        print(shuffledVariants)
        
        if let imageData = data.image {
            if imageData != "" {
                isLoadingImage = true
                image = Image(systemName: "star.fill")
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
    
    func isCorrectAnswer(_ answer: String) -> Bool {
        return answer == data.variants?.first
    }
}
