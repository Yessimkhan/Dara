//
//  MenuTabBar.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 10.03.2024.
//

import SwiftUI
import SwiftfulRouting

struct MenuTabBar: View {
    
    var body: some View {
        TabView {
            RouterView { router in
                HomePage(viewModel: HomeViewModel(router: router))
                    .navigationTitle("Lessons")
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            RouterView { router in
                AlphabetPage(viewModel: AlphabetViewModel(router: router))
                    .navigationTitle("Alphabet")
            }
            .tabItem {
                Label("Alphabet", systemImage: "character")
            }
            RouterView { router in
                ProfilePage(viewModel: ProfileViewModel(router: router))
                    .navigationTitle("Profile")
            }
            .tabItem {
                Label("Profile", systemImage: "person")
            }
        }
    }
}

#Preview {
    MenuTabBar()
}
