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
    @Published var isLoading: Bool = false
    @Published var image: Image?
    @Published var audioData: Data?
    @AppStorage("user_id") var userId: String?
    @Published var shuffledVariants: [String] = []

    init(router: AnyRouter, data: Content) {
        self.router = router
        self.data = data
        self.shuffledVariants = data.variants?.shuffled() ?? []
        print(shuffledVariants)
        
        if let imageData = data.image, imageData != "" {
            if imageData != "" {
                isLoading = true
                HomeRepository().downloadImage(from: imageData) { image in
                    self.isLoading = false
                    self.image = image
                }
            }
        }
    }
    
    func isCorrectAnswer(_ answer: String) -> Bool {
        return answer == data.variants?.first
    }
}
