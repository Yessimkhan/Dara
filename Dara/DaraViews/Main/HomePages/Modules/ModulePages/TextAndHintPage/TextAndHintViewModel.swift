//
//  TextAndHintViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 08.06.2024.
//

import Foundation
import SwiftUI
import SwiftfulRouting

final class TextAndHintViewModel: ObservableObject {
    
    let router: AnyRouter
    let data: [Content]
    private var downloadCount = 0
    @Published var textIndex = 0
    @Published var imagesArray: [Image] = []
    @Published var isLoadingImage: Bool = false
    @Published var image: Image?
    @Published var audioData: Data?
    @Published var isLoading: Bool = false
    @AppStorage("user_id") var userId: String?
    @AppStorage("userLanguage") var userLanguage: String?
    
    init(router: AnyRouter, data: [Content]) {
        self.router = router
        self.data = data
        
        isLoading = true
        for (_, data) in data.enumerated() {
            if data.contentType == "hint" {
                guard let content = data.content else { return }
                isLoading = true
                self.imagesArray = Array(repeating: Image(uiImage: UIImage()), count: content.count)
                var downloadImages = self.imagesArray
                for (index, url) in content.enumerated() {
                    HomeRepository().downloadImage(from: url) { [weak self] image in
                        guard let self = self else { return }
                        DispatchQueue.main.async {
                            downloadImages[index] = image ?? Image(systemName: "star.fill")
                            self.downloadCount += 1
                            if self.downloadCount == content.count {
                                self.isLoading = false
                                self.imagesArray = downloadImages
                            }
                        }
                    }
                }
            } else {
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
    }
    
    func getQuestion() -> String {
        if let question = data[textIndex].question , !question.isEmpty {
            return question
        } else {
            return "Тыңдаңыз және қайталаңыз."
        }
    }
    
    func getQuestionTranslation() -> String {
        if let question = data[textIndex].translation.question , !question.isEmpty {
            return question
        } else {
            if userLanguage == "ru" {
                return "Прослушайте и повторите."
            } else {
                return "Listen and repeat."
            }
        }
    }
}
