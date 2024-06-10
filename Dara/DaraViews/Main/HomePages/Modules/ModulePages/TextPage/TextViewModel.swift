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
    @AppStorage("userIid") var userId: String?
    @AppStorage("userLanguage") var userLanguage: String = NSLocale.current.language.languageCode?.identifier ?? "en"

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
    
    func getQuestion() -> String {
        if let question = data.question , !question.isEmpty {
            return question
        } else {
            return "Тыңдаңыз және қайталаңыз."
        }
    }
    
    func getQuestionTranslation() -> String {
        if let question = data.translation.question , !question.isEmpty {
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

