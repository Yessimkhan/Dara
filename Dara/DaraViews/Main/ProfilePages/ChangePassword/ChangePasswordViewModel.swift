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
    @Published var errorMessage: String? = nil
    @Published var currernPassword: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isCurrentPasswordVisible: Bool = false
    @Published var isPasswordVisible: Bool = false
    @Published var isConfirmPasswordVisible: Bool = false
    @Published var message: String = ""
    @Published var showMessage: Bool = false
    @AppStorage("userLanguage") var userLanguage: String = NSLocale.current.language.languageCode?.identifier ?? "en"

    init(router: AnyRouter) {
        self.router = router
    }
    
    func verifyPassword() {
        errorMessage = nil
        isDisabled = true
        if (currernPassword.count >= 8 && password.count >= 8) {
            if (password == confirmPassword) {
                isDisabled = false
            } else {
                errorMessage = String(localized: "Passwords do not match.")
            }
        } else {
            errorMessage = String(localized:"Password length must be at least 8 characters.")
        }
    }
    
    func changePassword() {
        isLoading = true
        isDisabled = true
        self.errorMessage = nil
        HomeRepository().updatePassword(oldPassword: currernPassword, newPassword: password) { result in
            self.isLoading = false
            self.isDisabled = false
            switch result {
            case .success(let response):
                self.showMessage = true
                self.message = response.message
            case .failure(let error):
                self.showMessage = true
                self.message = String(localized: "Failed to update password. Please try again later.")
                print("Update password failed \(error)")
            }
        }
    }
}
