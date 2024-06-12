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
    let userNameF: String
    let userNumber: String
    let userEmailF: String
    let password: String
    let level: UserLevel
    @Published var time: ChooseTimeView.TimeLevel = .five
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @AppStorage("isAuthorized") var isAuthorized: Bool = false
    @AppStorage("accessToken") var accessToken: String?
    @AppStorage("userId") var userId: String?
    @AppStorage("userLevel") var userLevel: Int = 1
    @AppStorage("userEmail") var userEmail: String?
    @AppStorage("userName") var userName: String?
    @AppStorage("userPhone") var userPhone: String?
    @AppStorage("userLanguage") var userLanguage: String = NSLocale.current.language.languageCode?.identifier ?? "en"

    init(router: AnyRouter, language: String, userName: String, userNumber: String, userEmail: String, password: String, level: UserLevel) {
        self.router = router
        self.language = language
        self.userNameF = userName
        self.userNumber = userNumber
        self.userEmailF = userEmail
        self.password = password
        self.level = level
    }
    
    func goMenuTabBar() {
        isLoading = true
        AuthRepository().register(level_id: level.levelValue, email: userEmailF, username: userNameF, phone: userNumber, password: password, language: language) { [weak self] result in
            switch result {
            case .success(let response):
                self?.getProfile(response: response)
            case .failure(let error):
                self?.isError = true
                self?.isLoading = false
                print("Register failed: \(error.localizedDescription)")
            }
        }
    }
    
    func getProfile(response: LoginResponse) {
        self.accessToken = response.accessToken
        self.userId = response.user.id
        HomeRepository().getProfile { [weak self] result in
            switch result {
            case .success(let profileResponse):
                DispatchQueue.main.async {
                    self?.userLevel = profileResponse.levelID
                    self?.userEmail = profileResponse.email
                    self?.userName = profileResponse.username
                    self?.userPhone = profileResponse.phone
                    self?.userLanguage = profileResponse.language
                    withAnimation {
                        self?.isLoading = false
                        self?.isAuthorized = true
                    }
                }
            case .failure(let error):
                self?.isLoading = false
                print("Get profile failed: \(error.localizedDescription)")
            }
        }
    }
}

