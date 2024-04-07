//
//  MenuTabBar.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 10.03.2024.
//

import SwiftUI

struct MenuTabBar: View {
    var body: some View {
        TabView {
            NavigationView {
                HomePage()
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            NavigationView {
                AlphabeetPage()
            }
            .tabItem {
                Label("Alphabet", systemImage: "character")
            }
            NavigationView {
                ProfilePage()
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
