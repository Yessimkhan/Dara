//
//  ShufflewordViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 06.06.2024.
//

import Foundation
import SwiftUI
import SwiftfulRouting

final class ShufflewordViewModel: ObservableObject {
    
    let router: AnyRouter
    let data: Content
    @Published var isLoadingImage: Bool = false
    @Published var image: Image?
    @Published var audioData: Data?
    @Published var shuffledVariants: [String] = []
    @Published var answerArray: [String] = []
    @Published var variantsDisabled: Bool = false
    @AppStorage("userId") var userId: String?
    @AppStorage("userLanguage") var userLanguage: String = NSLocale.current.language.languageCode?.identifier ?? "en"

    init(router: AnyRouter, data: Content) {
        self.router = router
        self.data = data
        self.shuffledVariants = data.variants?.shuffled() ?? []
        
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
    
    func isCorrectAnswer() -> Bool {
        if answerArray == data.variants {
            return true
        } else {
            return false
        }
    }
    
    func getQuestion() -> String {
        if let question = data.question , !question.isEmpty {
            return question
        } else {
            return "Сөздерді дұрыс орналастырыңыз."
        }
    }
    
    func getQuestionTranslation() -> String {
        if let question = data.translation.question , !question.isEmpty {
            return question
        } else {
            if userLanguage == "ru" {
                return "Расположите слова правильно."
            } else {
                return "Arrange the words correctly."
            }
        }
    }
}
