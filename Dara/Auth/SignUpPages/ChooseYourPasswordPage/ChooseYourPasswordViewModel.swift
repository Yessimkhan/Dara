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
    
    init(router: AnyRouter) {
        self.router = router
    }
    
    func goChooseLevelPage() {
        router.showScreen(.push) { router in
            ChooseLevelPage(viewModel: ChooseLevelViewModel(router: router))
        }
    }
    
}
