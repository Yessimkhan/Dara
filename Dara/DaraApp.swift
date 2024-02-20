//
//  DaraApp.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 20.02.2024.
//

import SwiftUI

@main
struct DaraApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
