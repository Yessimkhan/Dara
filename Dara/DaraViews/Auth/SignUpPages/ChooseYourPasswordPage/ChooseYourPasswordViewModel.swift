//
//  ChooseYourPasswordViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 07.04.2024.
//

import Foundation
import SwiftfulRouting

final class ChooseYourPasswordViewModel: ObservableObject {
    
    let router: AnyRouter
    let language: String
    let userName: String
    let userNumber: String
    let userEmail: String
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isPasswordVisible: Bool = false
    @Published var isConfirmPasswordVisible: Bool = false
    @Published var verified: Bool = true
    @Published var isError: Bool = false
    @Published var errorMessage: LocalizedStringResource? = nil
    
    init(router: AnyRouter, language: String, userName: String, userNumber: String, userEmail: String) {
        self.router = router
        self.language = language
        self.userName = userName
        self.userNumber = userNumber
        self.userEmail = userEmail
    }
    
    func verifyPassword() {
        errorMessage = nil
        verified = true
        if (password.count >= 8) {
            if (password == confirmPassword) {
                verified = false
            } else {
                errorMessage = "Passwords do not match."
            }
        } else {
            errorMessage = "Password length must be at least 8 characters."
        }
    }
    
    func goChooseLevelPage() {
        print("Password: \(password)")
        router.showScreen(.push) { router in
            ChooseLevelPage(viewModel: ChooseLevelViewModel(router: router, language: self.language, userName: self.userName, userNumber: self.userNumber, userEmail: self.userEmail, password: self.password))
                .navigationBarBackButtonHidden()
        }
    }
}
