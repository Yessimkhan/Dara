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
    
    var body: some Scene {
        WindowGroup {
            RouterView { router in
                RegistrationPageView(viewModel: RegistrationPageViewModel(router: router))
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
