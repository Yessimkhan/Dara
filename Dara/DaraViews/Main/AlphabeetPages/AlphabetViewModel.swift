//
//  AlphabetViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 10.06.2024.
//

import Foundation
import SwiftfulRouting
import SwiftUI

final class AlphabetViewModel: ObservableObject {
    let router: AnyRouter
    let data: AlphabetResponse = []
    @Published var audioData: [Data?] = []
    let alphabetArray: [Character] = Array("аәбвгғдеёжзийкқлмнңоөпрстуұүфхһцчшщъыіьэюя")
    
    init(router: AnyRouter) {
        self.router = router
        getAlphabetAudio()
    }
    
    func getAlphabetAudio() {
        self.audioData = Array(repeating: nil, count: alphabetArray.count)
        HomeRepository().getAlphabet { [weak self] result in
            switch result {
            case .success(let response):
                print("response.count \(response.count)")
                print("alphabetArray count \(self?.alphabetArray.count ?? 0)")
                for (index, url) in response.enumerated() {
                    HomeRepository().downloadAudio(from: url.audio) { [weak self] audio in
                        guard let self = self else { return }
                        print(audio != nil)
                        DispatchQueue.main.async {
                            self.audioData[index] = audio ?? Data()
                        }
                    }
                }
            case .failure(let error):
                print("Get alphabet failed: \(error)")
            }
        }
    }
}
