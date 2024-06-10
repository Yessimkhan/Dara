//
//  RegistrationPageViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 07.04.2024.
//

import Foundation
import SwiftfulRouting

final class RegistrationPageViewModel: ObservableObject {
    
    let router: AnyRouter
    
    init(router: AnyRouter) {
        self.router = router
    }
    
    func goCooseLanguagePageView() {
        router.showScreen(.push) { router in
            ChoseLanguagePage(viewModel: ChooseLanguageViewModel(router: router))
                .navigationBarBackButtonHidden()
        }
    }
}
