//
//  PersonalInformationViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 10.06.2024.
//

import Foundation
import SwiftfulRouting
import SwiftUI

class PersonalInformationViewModel: ObservableObject {
    
    let router: AnyRouter
    var username: Bool = true
    var phone: Bool = true
    var email: Bool = true
    
    @Published var isLoading: Bool = false
    @Published var isDisabled: Bool = true
    
    @Published var userNameF: String = ""
    @Published var userPhoneF: String = ""
    @Published var userEmailF: String = ""
    
    @Published var isError: Bool = false
    @Published var verified: Bool = true
    @Published var errorMessage: LocalizedStringResource? = nil
    
    @Published var message: LocalizedStringKey = ""
    @Published var showMessage: Bool = false
    
    @Published var deleteMessage: LocalizedStringResource = "Are you sure you want to delete your account?"
    @Published var showDeleteMessage: Bool = false
    
    @AppStorage("userLevel") var userLevel: Int = 1
    @AppStorage("userEmail") var userEmail: String?
    @AppStorage("userName") var userName: String?
    @AppStorage("userPhone") var userPhone: String?
    @AppStorage("userLanguage") var userLanguage: String = NSLocale.current.language.languageCode?.identifier ?? "en"

    init(router: AnyRouter) {
        self.router = router
        userNameF = userName ?? ""
        userPhoneF = userPhone ?? ""
        userEmailF = userEmail ?? ""
    }
    
    func verifyUsername() {
        verified = true
        if (userNameF.count < 3) {
            errorMessage = "Username is so short"
        } else if userNameF != userName {
            AuthRepository().checkUsername(username: userNameF) { [weak self] result in
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
        } else {
            self.username = true
            self.errorMessage = nil
            self.verify()
        }
    }
    
    func verifyPhone() {
        verified = true
        if (userPhoneF.count < 3) {
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
        if !(emailPred.evaluate(with: userEmailF)) {
            errorMessage = "Email is unavailable"
        } else {
            email = true
            errorMessage = nil
            verify()
        }
    }
    
    func verify() {
        verified = true
        if userNameF == userName && userEmailF == userEmail && userPhoneF.replacingOccurrences(of: " ", with: "") == userPhone?.replacingOccurrences(of: " ", with: "") {
            verified = true
        } else if (email && username && phone) {
            verified = false
        }
    }
    
    func updatePersonalInformation() {
        isLoading = true
        verified = true
        HomeRepository().updateProfile(levelId: userLevel, email: userEmailF, username: userNameF, phone: userPhoneF, language: userLanguage) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let profileResponse):
                self?.userLevel = profileResponse.levelID
                self?.userEmail = profileResponse.email
                self?.userName = profileResponse.username
                self?.userPhone = profileResponse.phone
                self?.userLanguage = profileResponse.language
                self?.showMessage = true
                self?.message = "Personal information has been successfully updated!"
            case .failure(let error):
                self?.showMessage = true
                self?.message = "Failed to update profile. Please try again later."
                self?.verified = true
                print("Update profile failed: \(error.localizedDescription)")
            }
        }
    }
    
    func showDeleteAccountAlert() {
        showDeleteMessage.toggle()
    }
    
    func deleteAccount() {
        router.showScreen(.push) { router in
            DeleteAccountPage(viewModel: DeleteAccountViewModel(router: router))
                .navigationTitle("Delete account")
                .navigationBarBackButtonHidden()
        }
    }
}
