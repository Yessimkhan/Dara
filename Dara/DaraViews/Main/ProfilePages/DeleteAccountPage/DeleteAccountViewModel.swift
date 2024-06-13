//
//  DeleteAccountViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 13.06.2024.
//

import Foundation
import SwiftUI
import SwiftfulRouting

final class DeleteAccountViewModel: ObservableObject {
    
    let router: AnyRouter
    @Published var username: String = ""
    @Published var isError: Bool = false
    @Published var disabled: Bool = true
    @Published var isLoading: Bool = false
    
    @Published var showMessage: Bool = false
    @Published var message: LocalizedStringKey = ""
    
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
    
    func checkUsername() {
        disabled = true
        if username == userName {
            disabled = false
        }
    }
    
    func deleteAccount() {
        disabled = true
        isLoading = true
        HomeRepository().deleteAccount { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(_):
                self?.isAuthorized = false
                self?.accessToken = nil
                self?.userId = nil
                self?.userLevel = 1
                self?.userEmail = nil
                self?.userName = nil
                self?.userPhone = nil
                self?.userLanguage = NSLocale.current.language.languageCode?.identifier ?? "en"
            case .failure(_):
                self?.disabled = false
                self?.showMessage = true
                self?.message = "Failed to delete account. Please try again later."
            }
        }
    }
}
