//
//  MiniLoaderView.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 06.06.2024.
//

import SwiftUI

struct MiniLoaderView: View {
    @State private var isAnimating = false
    
    var body: some View {
        GradientCircularLoaderMini()
            .rotationEffect(Angle(degrees: self.isAnimating ? 360 : 0))
            .animation(Animation.linear(duration: 0.8).repeatForever(autoreverses: false), value: isAnimating)
            .onAppear() {
                self.isAnimating = true
            }
            .onDisappear() {
                self.isAnimating = false
            }
    }
}

struct GradientCircularLoaderMini: View {
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.7)  // Partial circle for the loader effect
            .stroke(LinearGradient(colors: [Colors.brandPrimary,.blue], startPoint: .topLeading, endPoint: .bottomTrailing),style: StrokeStyle(lineWidth: 4.5,lineCap: .round,lineJoin:.round))
            .rotationEffect(Angle(degrees: -90)) // Start from the top
            .frame(width: 30, height: 30)
    }
}

#Preview {
    MiniLoaderView()
}
