//
//  DaraApp.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 20.02.2024.
//

import SwiftUI
import SwiftfulRouting

@main
struct DaraApp: App {
    
    let persistenceController = PersistenceController.shared
    @AppStorage("isAuthorized") var isAuthorized: Bool = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            if !isAuthorized {
                RouterView { router in
                    SignInPage(viewModel: SignInViewModel(router: router))
                }
            } else {
                MenuTabBar()
            }
        }
    }
}
