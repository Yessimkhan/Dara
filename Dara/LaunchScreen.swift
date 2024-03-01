//
//  LaunchScreen.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 20.02.2024.
//

import SwiftUI


struct LaunchScreen: View {
    @State private var showView = false
    @State private var goToMainView = false

    var body: some View {
        NavigationView {
            VStack {
                if showView {
                    VStack(spacing: 20){
                        Image(systemName: "star.fill")
                            .font(.system(size: 150))
                        Text("Dara language learnig app")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .bottom),
                            removal: .move(edge: .top))
                    )
                    .animation(.spring(duration: 1.0))
                    
                }
                
                NavigationLink(destination: RegistrationPage().navigationBarBackButtonHidden(), isActive: $goToMainView) {}
                
            }
            .onAppear() {
                self.showView.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.showView.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            goToMainView = true
                        }
                    }
                }
            }
            .foregroundStyle(Color.green)
            
        }
    }
}


#Preview {
    LaunchScreen()
}
