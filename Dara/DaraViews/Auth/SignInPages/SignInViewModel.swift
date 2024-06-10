//
//  SignInViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 07.04.2024.
//

import Foundation
import SwiftfulRouting
import SwiftUI

final class SignInViewModel: ObservableObject {
    
    let router: AnyRouter
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isError: Bool = false
    @Published var errorMessage: LocalizedStringResource? = nil
    @Published var isLoading: Bool = false
    @AppStorage("isAuthorized") var isAuthorized: Bool = false
    @AppStorage("accessToken") var accessToken: String?
    @AppStorage("userId") var userId: String?
    @AppStorage("userLevel") var userLevel: Int = 1
    @AppStorage("userEmail") var userEmail: String?
    @AppStorage("userName") var userName: String?
    @AppStorage("userPhone") var userPhone: String?
    @AppStorage("userLanguage") var userLanguage: String = NSLocale.current.language.languageCode?.identifier ?? "en"

    init(router: AnyRouter) {
        self.router = router
    }
    
    func goMenuTabBar() {
    }
    
    func goForgotPasswordPage() {
        router.showScreen(.push) { router in
            ForgotPasswordPage(viewModel: ForgotPasswordViewModel(router: router))
                .navigationBarBackButtonHidden()
        }
    }
    
    func goRegistrationPage() {
        router.showScreen(.push) { router in
            RegistrationPageView(viewModel: RegistrationPageViewModel(router: router))
                .navigationBarBackButtonHidden()
        }
    }
    
    func verifyEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailPred.evaluate(with: email) {
            return true
        } else {
            return false
        }
    }
    
    func signInButtonTapped() {
        isLoading = true
        if !verifyEmail() {
            AuthRepository().loginWithUsername(username: email, password: password) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.getProfile(response: response)
                case .failure(let error):
                    self?.isError = true
                    self?.errorMessage = "Username or Password is Incorrect"
                    print("Login failed: \(error.localizedDescription)")
                }
            }
        } else {
            AuthRepository().login(email: email, password: password) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.getProfile(response: response)
                case .failure(let error):
                    self?.isError = true
                    self?.errorMessage = "Email or Password is Incorrect"
                    print("Login failed: \(error.localizedDescription)")
                }
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
                print("Get profile failed: \(error.localizedDescription)")
            }
        }
    }
}
