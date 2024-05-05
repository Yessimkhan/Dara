//
//  LoaderView.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 15.04.2024.
//

import SwiftUI

struct LoaderView: View {
    @State private var isAnimating = false
    
    var body: some View {
        GradientCircularLoader()
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

struct GradientCircularLoader: View {
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.7)  // Partial circle for the loader effect
            .stroke(LinearGradient(colors: [Colors.brandPrimary,.blue], startPoint: .topLeading, endPoint: .bottomTrailing),style: StrokeStyle(lineWidth: 5.5,lineCap: .round,lineJoin:.round))
            .rotationEffect(Angle(degrees: -90)) // Start from the top
            .frame(width: 50, height: 50)
    }
}

#Preview {
    LoaderView()
}
