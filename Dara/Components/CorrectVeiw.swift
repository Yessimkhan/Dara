//
//  CorrectVeiw.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 01.05.2024.
//

import SwiftUI
import SwiftfulRouting

struct CorrectView: View {
    let router: AnyRouter
    @StateObject var modulePagesViewModel: ModulePagesViewModel
    var body: some View {
        if !modulePagesViewModel.isLoading {
            VStack (spacing: 21){
                Text("Correct Answer!")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(Colors.white)
                Button {
                    modulePagesViewModel.getPages()
                } label: {
                    if modulePagesViewModel.currentPage > modulePagesViewModel.allPages {
                        ButtonView(buttonType: .finish)
                    } else {
                        ButtonView(buttonType: .continue)
                    }
                    
                }
            }
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity)
            .frame(height: 190)
            .background(Colors.correctAnswer)
            .cornerRadius(30)
        }
    }
}
