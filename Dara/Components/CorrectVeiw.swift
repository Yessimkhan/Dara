//
//  CorrectVeiw.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 01.05.2024.
//

import SwiftUI

struct CorrectView: View {
    @StateObject var modulePagesViewModel: ModulePagesViewModel
    var body: some View {
        VStack (spacing: 21){
            Text("Correct Answer!")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Colors.white)
            Button {
                modulePagesViewModel.router.dismissModal()
                modulePagesViewModel.getPages()
            } label: {
                ButtonView(buttonType: .continue, withBackground: true)
                
            }
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity)
        .frame(height: 190)
        .background(Colors.correctAnswer)
        .cornerRadius(30)
    }
}
