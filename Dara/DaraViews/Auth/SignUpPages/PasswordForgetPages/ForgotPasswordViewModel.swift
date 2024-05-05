//
//  ForgotPasswordViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 07.04.2024.
//

import Foundation
import SwiftfulRouting

final class ForgotPasswordViewModel: ObservableObject {
    
    let router: AnyRouter
    @Published var isError: Bool = false
    
    init(router: AnyRouter) {
        self.router = router
    }
    
    func goResetPasswordPage() {
        router.showScreen(.push) { router in
            ResetPasswordPage(viewModel: self)
        }
    }
    
    func goMainTabBar() {
        router.showScreen(.push) { router in
            MenuTabBar().navigationBarBackButtonHidden()
        }
    }
}
