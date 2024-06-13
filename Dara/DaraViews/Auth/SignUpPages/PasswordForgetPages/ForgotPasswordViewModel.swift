//
//  ForgotPasswordViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 07.04.2024.
//

import Foundation
import SwiftfulRouting
import SwiftUI

final class ForgotPasswordViewModel: ObservableObject {
    
    let router: AnyRouter
    @Published var isError: Bool = false
    @Published var isLoading: Bool = false
    @Published var isDisabled: Bool = true
    @Published var email: String = ""
    @Published var message: LocalizedStringResource?
    @Published var showMessage: Bool = false
    @AppStorage("userLanguage") var userLanguage: String = NSLocale.current.language.languageCode?.identifier ?? "en"

    init(router: AnyRouter) {
        self.router = router
    }
    
    func sendEmail() {
        isLoading = true
        isDisabled = true
        AuthRepository().forgotPassword(email: email) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let response):
                self?.showMessage = true
                self?.message =  LocalizedStringResource(stringLiteral: response.message)
            case .failure(let error):
                self?.showMessage = true
                self?.message = "Failed to send email. Please try again later."
                print("Send email failed \(error)")
            }
        }
    }
    
    func verifyEmail() {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailPred.evaluate(with: email) {
            isDisabled = false
        } else {
            isDisabled = true
        }
    }
}
