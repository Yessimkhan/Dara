//
//  WrongView.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 01.05.2024.
//

import SwiftUI
import SwiftfulRouting

struct WrongView: View {
    let router: AnyRouter
    @StateObject var modulePagesViewModel: ModulePagesViewModel
    var body: some View {
        if !modulePagesViewModel.isLoading {
            VStack (spacing: 21){
                Text("Wrong Answer!")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(Colors.white)
                Button {
                    modulePagesViewModel.getPages()
                } label: {
                    ButtonView(buttonType: .continue, withBackground: true)
                    
                }
            }
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity)
            .frame(height: 190)
            .background(Colors.wrongAnswer)
            .cornerRadius(30)
        }
    }
}