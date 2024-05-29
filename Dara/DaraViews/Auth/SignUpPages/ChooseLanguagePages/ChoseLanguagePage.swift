//
//  ChoseLanguagePage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 27.02.2024.
//

import SwiftUI
import SwiftfulRouting

struct ChoseLanguagePage: View {
    
    @StateObject var viewModel: ChooseLanguageViewModel
    
    var body: some View {
        ZStack {
            VStack (spacing: 40) {
                Images.eaglesImage
                
                HStack (spacing: 20){
                    Button {
                        viewModel.language = "us"
                        viewModel.goCreateAccountPage()
                    } label: {
                        ButtonView(buttonType: .eng)
                    }
                    
                    Button {
                        viewModel.language = "ru"
                        viewModel.goCreateAccountPage()
                    } label: {
                        ButtonView(buttonType: .rus)
                    }
                }
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    RouterView { router in
        ChoseLanguagePage(viewModel: ChooseLanguageViewModel(router: router))
    }
    
}
