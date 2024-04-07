//
//  ContentView.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 20.02.2024.
//

import SwiftUI
import SwiftfulRouting

struct ContentView: View {
    var body: some View {
        RouterView { _ in
            MyView()
        }
    }
}

struct MyView: View {
    @Environment(\.router) var router
    var body: some View {
        Text("Hello, world!")
            .onTapGesture {
                router.showScreen(.push) { _ in
                    Text("Another screen!")
                }
            }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
