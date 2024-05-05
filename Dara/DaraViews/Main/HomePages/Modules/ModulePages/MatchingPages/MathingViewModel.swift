//
//  MathingViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 27.04.2024.
//

import Foundation
import SwiftUI

final class MathingViewModel: ObservableObject {
    
    let data: [Content]
    @Published var isLoading: Bool = false
    @Published var image: Image?
    @Published var shuffledQuestions: [Content]
    @Published var shuffledAnswers: [Content]
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
    
    init(data: [Content]) {
        self.data = data
        self.shuffledQuestions = data.shuffled()
        self.shuffledAnswers = data.shuffled()
    }
    
    func isCorrectMatch() {
        var isCorrect = false
        if let selectedA = selectedA, let selectedQ = selectedQ {
            if let index = self.data.firstIndex(where: {$0.title == shuffledQuestions[selectedQ].title}) {
                if self.data[index].translation.title == shuffledAnswers[selectedA].translation.title {
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
            self.selectedA = nil
            self.selectedQ = nil
        }
        
    }
}
