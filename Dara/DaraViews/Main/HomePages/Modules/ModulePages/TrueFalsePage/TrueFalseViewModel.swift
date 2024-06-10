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
    @Published var shuffledVariants: [String] = []
    @Published var variantsDisabled: Bool = false
    @AppStorage("userId") var userId: String?
    @AppStorage("userLanguage") var userLanguage: String = NSLocale.current.language.languageCode?.identifier ?? "en"

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
    
    func getQuestion() -> String {
        if let question = data.question , !question.isEmpty {
            return question
        } else {
            return "Дұрыс немесе бұрыс екенін табыңыз."
        }
    }
    
    func getQuestionTranslation() -> String {
        if let question = data.translation.question , !question.isEmpty {
            return question
        } else {
            if userLanguage == "ru" {
                return "Угадайте, что правильно или неправильно."
            } else {
                return "Guess what is true or false."
            }
        }
    }
}
