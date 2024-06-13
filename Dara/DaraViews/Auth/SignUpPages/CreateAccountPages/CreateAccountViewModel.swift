//
//  CreateAccountViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 07.04.2024.
//

import Foundation
import SwiftfulRouting

final class CreateAccountViewModel: ObservableObject {
    
    let router: AnyRouter
    let language: String
    @Published var userName: String = ""
    @Published var userNumber: String = ""
    @Published var userEmail: String = ""
    @Published var isError: Bool = false
    @Published var verified: Bool = true
    @Published var errorMessage: LocalizedStringResource? = nil
    var username: Bool = false
    var phone: Bool = false
    var email: Bool = false
    
    init(router: AnyRouter, language: String) {
        self.router = router
        self.language = language
    }
    
    func verifyUsername() {
        verified = true
        if (userName.count < 3) {
            errorMessage = "Username is so short"
        } else {
            AuthRepository().checkUsername(username: userName) { [weak self] result in
                switch result {
                case .success(let response):
                    if response.isExists {
                        self?.username = false
                        self?.verified = true
                        self?.errorMessage = "This username is already taken"
                    } else {
                        self?.username = true
                        self?.errorMessage = nil
                        self?.verify()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func verifyPhone() {
        verified = true
        if (userNumber.count < 3) {
            errorMessage = "Phone Number is unavailable"
        } else {
            phone = true
            errorMessage = nil
            verify()
        }
    }
    
    func verifyEmail() {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        verified = true
        if !(emailPred.evaluate(with: userEmail)) {
            errorMessage = "Email is unavailable"
        } else {
            email = true
            errorMessage = nil
            verify()
        }
    }
    
    func verify() {
        verified = true
        if (email && username && phone) {
            verified = false
        }
    }
    
    func goChooseYourPassword() {
        print("Username: \(userName)")
        print("Phone: \(userNumber)")
        print("Email: \(userEmail)")
        router.showScreen(.push) { router in
            ChooseYourPasswordPage(viewModel: ChooseYourPasswordViewModel(router: router, language: self.language, userName: self.userName, userNumber: self.userNumber, userEmail: self.userEmail))
                .navigationBarBackButtonHidden()
        }
    }
    
}
