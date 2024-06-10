//
//  MathingViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 27.04.2024.
//

import Foundation
import SwiftUI
import SwiftfulRouting

final class MatchingViewModel: ObservableObject {
    
    let router: AnyRouter
    let data: [Content]
    @Published var isLoading: Bool = false
    @Published var image: Image?
    @Published var shuffledQuestions: [String] = []
    @Published var shuffledAnswers: [String] = []
    @Published var isSelected0: Bool = false
    @Published var isCorrect0: Bool? = nil
    @Published var isSelected1: Bool = false
    @Published var isCorrect1: Bool? = nil
    @Published var isSelected2: Bool = false
    @Published var isCorrect2: Bool? = nil
    @Published var isSelected10: Bool = false
    @Published var isCorrect10: Bool? = nil
    @Published var isSelected11: Bool = false
    @Published var isCorrect11: Bool? = nil
    @Published var isSelected12: Bool = false
    @Published var isCorrect12: Bool? = nil
    @Published var selectedQ: Int? = nil
    @Published var selectedA: Int? = nil
    @Published var isDisabled: Bool = true
    @AppStorage("userLanguage") var userLanguage: String = NSLocale.current.language.languageCode?.identifier ?? "en"

    init(router: AnyRouter, data: [Content]) {
        self.router = router
        self.data = data
        let firstThreeElements = Array(data.prefix(3))
        for element in firstThreeElements {
            shuffledQuestions.append(element.variants?.first ?? "")
            shuffledAnswers.append(element.variants?.last ?? "")
        }
        self.shuffledQuestions = shuffledQuestions.shuffled()
        self.shuffledAnswers = shuffledAnswers.shuffled()
    }
    
    func isCorrectMatch() {
        var isCorrect = false
        if let selectedA = selectedA, let selectedQ = selectedQ {
            if let index = self.data.firstIndex(where: {$0.variants?.first == shuffledQuestions[selectedQ]}) {
                if self.data[index].variants?.last == shuffledAnswers[selectedA] {
                    isCorrect = true
                }
            }
            if selectedA == 0 {
                isCorrect10 = isCorrect
                isSelected10 = false
                if !isCorrect {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.isCorrect10 = nil
                    }
                }
            }
            if selectedA == 1 {
                isCorrect11 = isCorrect
                isSelected11 = false
                if !isCorrect {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.isCorrect11 = nil
                    }
                }
            }
            if selectedA == 2 {
                isCorrect12 = isCorrect
                isSelected12 = false
                if !isCorrect {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.isCorrect12 = nil
                    }
                }
            }
            if selectedQ == 0 {
                isCorrect0 = isCorrect
                isSelected0 = false
                if !isCorrect {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.isCorrect0 = nil
                    }
                }
            }
            if selectedQ == 1 {
                isCorrect1 = isCorrect
                isSelected1 = false
                if !isCorrect {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.isCorrect1 = nil
                    }
                }
            }
            if selectedQ == 2 {
                isCorrect2 = isCorrect
                isSelected2 = false
                if !isCorrect {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.isCorrect2 = nil
                    }
                }
            }
            
            if (isCorrect0 == true && isCorrect1 == true && isCorrect10 == true && isCorrect11 == true) {
                if data.count >= 3 {
                    if (isCorrect2 == true && isCorrect12 == true) {
                        self.isDisabled = false
                    }
                } else {
                    self.isDisabled = false
                }
            }
            self.selectedA = nil
            self.selectedQ = nil
        }
        
    }
    
    func getQuestion() -> String {
        if let question = data[0].question , !question.isEmpty {
            return question
        } else {
            return "Дұрыс жауаппен сәйкестендіріңіз."
        }
    }
    
    func getQuestionTranslation() -> String {
        if let question = data[0].translation.question , !question.isEmpty {
            return question
        } else {
            if userLanguage == "ru" {
                return "Сопоставьте правильный ответ."
            } else {
                return "Match with the correct answer."
            }
        }
    }
}
