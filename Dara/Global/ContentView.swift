//
//  ContentView.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 20.02.2024.
//

import SwiftUI
import SwiftfulRouting

struct ContentView: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(AngularGradient(gradient: Gradient(colors: [Colors.brandPrimary, Color.blue]), center: .center), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .frame(width: 50, height: 50)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
                .onAppear() {
                    isAnimating = true
                }
        }
    }
}

#Preview {
    ContentView()
}
