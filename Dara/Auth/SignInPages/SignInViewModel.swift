//
//  SignInViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 07.04.2024.
//

import Foundation
import SwiftfulRouting

final class SignInViewModel: ObservableObject {
    
    let router: AnyRouter
    
    init(router: AnyRouter) {
        self.router = router
    }
    
    func goMenuTabBar() {
        router.showScreen(.push) { router in
            MenuTabBar().navigationBarBackButtonHidden()
        }
    }
    
    func goForgotPasswordPage() {
        router.showScreen(.push) { router in
            ForgotPasswordPage(viewModel: ForgotPasswordViewModel(router: router))
        }
    }
    
    func goRegistrationPage() {
        router.showScreen(.push) { router in
            RegistrationPageView(viewModel: RegistrationPageViewModel(router: router))
        }
    }
}
