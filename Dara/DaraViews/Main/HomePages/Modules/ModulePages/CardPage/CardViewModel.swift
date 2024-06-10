//
//  CardViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 27.05.2024.
//

import Foundation
import SwiftUI
import SwiftfulRouting

final class CardViewModel: ObservableObject {
    
    let router: AnyRouter
    let data: Content
    @Published var isLoadingImage: Bool = false
    @Published var image: Image?
    @Published var audioData: Data?
    @AppStorage("userId") var userId: String?
    @AppStorage("userLanguage") var userLanguage: String = NSLocale.current.language.languageCode?.identifier ?? "en"

    init(router: AnyRouter, data: Content) {
        self.router = router
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
    
    func getQuestion() -> String {
        if let question = data.question , !question.isEmpty {
            return question
        } else {
            return "Жаңа сөз"
        }
    }
    
    func getQuestionTranslation() -> String {
        if let question = data.translation.question , !question.isEmpty {
            return question
        } else {
            if userLanguage == "ru" {
                return "Новое слово"
            } else {
                return "A new word"
            }
        }
    }
}
