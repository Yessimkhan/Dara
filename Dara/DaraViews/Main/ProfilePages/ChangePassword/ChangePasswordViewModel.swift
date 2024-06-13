//
//  ChangePasswordViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 10.06.2024.
//

import Foundation
import SwiftfulRouting
import SwiftUI
import PhotosUI

class ChangePasswordViewModel: ObservableObject {
    let router: AnyRouter
    @Published var isError: Bool = false
    @Published var isLoading: Bool = false
    @Published var isDisabled: Bool = true
    @Published var showErrorMessge: Bool = false
    @Published var errorMessage: LocalizedStringResource? = nil
    @Published var currernPassword: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isCurrentPasswordVisible: Bool = false
    @Published var isPasswordVisible: Bool = false
    @Published var isConfirmPasswordVisible: Bool = false
    @Published var message: LocalizedStringResource? = ""
    @Published var showMessage: Bool = false
    @AppStorage("userLanguage") var userLanguage: String = NSLocale.current.language.languageCode?.identifier ?? "en"

    init(router: AnyRouter) {
        self.router = router
    }
    
    func verifyPassword() {
        showErrorMessge = false
        errorMessage = nil
        isDisabled = true
        if (currernPassword.count >= 8 && password.count >= 8) {
            if (password == confirmPassword) {
                isDisabled = false
            } else {
                showErrorMessge = true
                errorMessage = "Passwords do not match."
            }
        } else {
            showErrorMessge = true
            errorMessage = "Password length must be at least 8 characters."
        }
    }
    
    func changePassword() {
        isLoading = true
        isDisabled = true
        HomeRepository().updatePassword(oldPassword: currernPassword, newPassword: password) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let response):
                self?.showMessage = true
                self?.message = LocalizedStringResource(stringLiteral: response.message)
                self?.currernPassword = ""
                self?.password = ""
                self?.confirmPassword = ""
                self?.showErrorMessge = false
                self?.errorMessage = nil
            case .failure(let error):
                self?.isDisabled = false
                self?.showMessage = true
                self?.message = "Failed to update password. Please try again later."
                print("Update password failed \(error)")
            }
        }
    }
}
