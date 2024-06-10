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
    @AppStorage("userLanguage") var userLanguage: String = NSLocale.current.language.languageCode?.identifier ?? "en"
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            if !isAuthorized {
                RouterView { router in
                    SignInPage(viewModel: SignInViewModel(router: router))
                        .environment(\.locale, Locale(identifier: userLanguage))
                }
            } else {
                MenuTabBar()
                    .environment(\.locale, Locale(identifier: userLanguage))
            }
        }
    }
}
