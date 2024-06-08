//
//  DialogViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 09.05.2024.
//

import SwiftUI
import SwiftfulRouting

final class DialogViewModel: ObservableObject {
    
    let router: AnyRouter
    let data: [Content]
    @Published var audioData: [Data?] = []
    @Published var isPlaying: [Bool] = []
    @Published var isLoading: Bool = false
    private var downloadCount = 0
    @AppStorage("userLanguage") var userLanguage: String?
    
    init(router: AnyRouter, data: [Content]) {
        self.router = router
        self.data = data
        self.isLoading = true
        self.audioData = Array(repeating: nil, count: data.count)
        self.isPlaying = Array(repeating: false, count: data.count)
        var downloadAudios = self.audioData
        for (index, url) in data.enumerated() {
            HomeRepository().downloadAudio(from: url.audio ?? "") { [weak self] audio in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    downloadAudios[index] = audio ?? Data()
                    self.downloadCount += 1
                    if self.downloadCount == data.count {
                        self.isLoading = false
                        self.audioData = downloadAudios
                    }
                }
            }
        }
    }
    
    func getQuestion() -> String {
        if let question = data[0].question , !question.isEmpty {
            return question
        } else {
            return "Тыңдаңыз және қайталаңыз."
        }
    }
    
    func getQuestionTranslation() -> String {
        if let question = data[0].translation.question , !question.isEmpty {
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
