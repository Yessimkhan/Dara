//
//  ChooseLanguageViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 07.04.2024.
//

import Foundation
import SwiftfulRouting

final class ChooseLanguageViewModel: ObservableObject {
    
    let router: AnyRouter
    
    init(router: AnyRouter) {
        self.router = router
    }
    
    func goCreateAccountPage() {
        router.showScreen(.push) { router in
            CreateAccountPage(viewModel: CreateAccountViewModel(router: router))
        }
    }
    
}
