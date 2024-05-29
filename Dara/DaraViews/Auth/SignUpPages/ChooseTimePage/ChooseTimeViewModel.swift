//
//  ChooseTimeViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 07.04.2024.
//

import SwiftUI
import SwiftfulRouting

final class ChooseTimeViewModel: ObservableObject {
    
    let router: AnyRouter
    let language: String
    let userName: String
    let userNumber: String
    let userEmail: String
    let password: String
    let level: ChooseLevelView.LanguageLevel
    @Published var time: ChooseTimeView.TimeLevel = .five
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @AppStorage("isAuthorized") var isAuthorized: Bool = false
    @AppStorage("accessToken") var accessToken: String?
    @AppStorage("userLanguage") var userLanguage: String?
    @AppStorage("userId") var userId: String?
    
    init(router: AnyRouter, language: String, userName: String, userNumber: String, userEmail: String, password: String, level: ChooseLevelView.LanguageLevel) {
        self.router = router
        self.language = language
        self.userName = userName
        self.userNumber = userNumber
        self.userEmail = userEmail
        self.password = password
        self.level = level
    }
    
    func goMenuTabBar() {
        print("Language: \(language)")
        print("UserName: \(userName)")
        print("UserNumber: \(userNumber)")
        print("UserEmail: \(userEmail)")
        print("Password: \(password)")
        print("Level: \(level.levelValue)")
        print("Time: \(time.rawValue)")
        
        AuthRepository().register(level_id: level.levelValue, email: userEmail, username: userName, phone: userNumber, password: password, language: language) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    withAnimation {
                        self?.isAuthorized = true
                    }
                    self?.accessToken = response.accessToken
                    self?.userLanguage = response.user.language
                    self?.userId = response.user.id
                    print("You are registered successfully. Access Token: \(String(describing: self?.accessToken))")
                    print("UserID: \(String(describing: self?.userId))")
                    print("UserLanguage: \(String(describing: self?.userLanguage))")
                    print("UserEmail: \(String(describing: self?.userEmail))")
                case .failure(let error):
                    self?.isError = true
                    print("Register failed: \(error.localizedDescription)")
                }
            }
        }
    }
}

