//
//  ChooseTimeViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 07.04.2024.
//

import Foundation
import SwiftfulRouting

final class ChooseTimeViewModel: ObservableObject {
    
    let router: AnyRouter
    
    init(router: AnyRouter) {
        self.router = router
    }
    
    func goMenuTabBar() {
        
        router.showScreen(.push) { router in
            MenuTabBar().navigationBarBackButtonHidden()
        }
        DispatchQueue.main.async {
            UserDefaults.standard.set(true, forKey: "isLogin")
        }
    }
}

