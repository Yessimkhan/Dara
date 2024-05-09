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
    @Published var isLoading: Bool = false
    @AppStorage("isAuthorized") var isAuthorized: Bool = false
    @AppStorage("accessToken") var accessToken: String?
    @AppStorage("acceptLanguage") var acceptLanguage: String?
    @AppStorage("userId") var userId: String?
    
    init(router: AnyRouter) {
        self.router = router
    }
    
    func goMenuTabBar() {
    }
    
    func goForgotPasswordPage() {
        router.showScreen(.push) { router in
            ForgotPasswordPage(viewModel: ForgotPasswordViewModel(router: router))
        }
    }
    
    func goRegistrationPage() {
        router.showScreen(.push) { router in
            RegistrationPageView(viewModel: RegistrationPageViewModel(router: router)).navigationBarBackButtonHidden()
        }
    }
    
    func signInButtonTapped() {
        isLoading = true 
        AuthRepository().login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    withAnimation {
                        self?.isAuthorized = true
                    }
                    self?.accessToken = response.accessToken
                    self?.acceptLanguage = "en"
                    self?.userId = response.user.id
                    print("Login successful. Access Token: \(String(describing: self?.accessToken))")
                    print("Accept Language: \(String(describing: self?.acceptLanguage))")
                case .failure(let error):
                    self?.isError = true
                    print("Login failed: \(error.localizedDescription)")
                }
            }
        }
    }
}
