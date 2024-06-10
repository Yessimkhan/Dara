//
//  ChooseLevelViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 07.04.2024.
//

import Foundation
import SwiftfulRouting

final class ChooseLevelViewModel: ObservableObject {
    
    let router: AnyRouter
    let language: String
    let userName: String
    let userNumber: String
    let userEmail: String
    let password: String
    @Published var level: UserLevel = .A1
    
    init(router: AnyRouter, language: String, userName: String, userNumber: String, userEmail: String, password: String) {
        self.router = router
        self.language = language
        self.userName = userName
        self.userNumber = userNumber
        self.userEmail = userEmail
        self.password = password
    }
    
    func goChooseTimePage() {
        print("Level: \(level.levelValue)")
        router.showScreen(.push) { router in
            ChooseTimePage(viewModel: ChooseTimeViewModel(router: router, language: self.language, userName: self.userName, userNumber: self.userNumber, userEmail: self.userEmail, password: self.password, level: self.level))
                .navigationBarBackButtonHidden()
        }
    }
}
