//
//  ChooseLevelViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 07.04.2024.
//

import Foundation
import SwiftfulRouting

final class ChooseLevelViewModel: ObservableObject {
    
    let router: AnyRouter
    
    init(router: AnyRouter) {
        self.router = router
    }
    
    func goChooseTimePage() {
        router.showScreen(.push) { router in
            ChooseTimePage(viewModel: ChooseTimeViewModel(router: router))
        }
    }
}
