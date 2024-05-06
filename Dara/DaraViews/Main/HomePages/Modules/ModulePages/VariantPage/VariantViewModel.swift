//
//  VariantViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 23.04.2024.
//

import Foundation
import SwiftUI
import SwiftfulRouting

final class VariantViewModel: ObservableObject {
    
    let router: AnyRouter
    let data: Content
    @Published var isLoading: Bool = false
    @Published var image: Image?
    @Published var audioData: Data?
    @AppStorage("user_id") var userId: String?
    @Published var shuffledVariants: [String] = []
    
    init(router: AnyRouter, data: Content) {
        self.router = router
        self.data = data
        self.shuffledVariants = data.variants?.shuffled() ?? []
        
        if let imageData = data.image {
            if imageData != "" {
                isLoading = true
                HomeRepository().downloadImage(from: imageData) { image in
                    self.isLoading = false
                    self.image = image
                }
            }
        }
        
        if let audio = data.audio {
            if audio != "" {
                HomeRepository().downloadAudio(from:  audio) { data in
                    self.audioData = data
                }
            }
        }
    }
    func isCorrectAnswer(_ answer: String) -> Bool {
        return answer == data.variants?.first
    }
}
