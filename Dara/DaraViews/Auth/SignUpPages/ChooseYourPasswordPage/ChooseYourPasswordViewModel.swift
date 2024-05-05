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
    @Published var isError: Bool = false
    
    init(router: AnyRouter) {
        self.router = router
    }
    
    func goChooseLevelPage() {
        router.showScreen(.push) { router in
            ChooseLevelPage(viewModel: ChooseLevelViewModel(router: router))
        }
    }
    
    func goSignInPageView() {
        router.showScreen(.push) { router in
            SignInPage(viewModel: SignInViewModel(router: router)).navigationBarBackButtonHidden()
        }
    }
}
