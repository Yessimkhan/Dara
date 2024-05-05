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
    @Published var isError: Bool = false
    
    init(router: AnyRouter) {
        self.router = router
    }
    
    func goChooseYourPassword() {
        router.showScreen(.push) { router in
            ChooseYourPasswordPage(viewModel: ChooseYourPasswordViewModel(router: router))
        }
    }
    
}
