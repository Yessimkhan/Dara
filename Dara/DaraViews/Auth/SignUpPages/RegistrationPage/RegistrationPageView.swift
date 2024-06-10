//
//  RegistrationPageView.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 27.02.2024.
//

import SwiftUI
import SwiftfulRouting

struct RegistrationPageView: View {
    
    @StateObject var viewModel: RegistrationPageViewModel
    @AppStorage("userLanguage") var userLanguage: String = NSLocale.current.language.languageCode?.identifier ?? "en"

    var body: some View {
        ZStack {
            VStack{
                Image("topLineImage")
                Spacer()
            }
            
            ZStack {
                Image("eaglesImage")
                    .font(.system(size: 100))
                    .foregroundColor(Colors.alphabet)
                VStack (spacing: 24) {
                    Spacer()
                    Button {
                        viewModel.goCooseLanguagePageView()
                    } label: {
                        ButtonView(buttonType: .chooseYourLanguage)
                    }
                    
                    Button {
                        viewModel.router.dismissScreenStack()
                    } label: {
                        SingleButtonView(buttonType: .signIn)
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 42)
        }
        .environment(\.locale, Locale(identifier: userLanguage))
    }
}

#Preview {
    RouterView {router in
        RegistrationPageView(viewModel: RegistrationPageViewModel(router: router))
    }
}
