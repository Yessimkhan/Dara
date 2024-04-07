//
//  SingleButtonView.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 05.04.2024.
//

import SwiftUI

enum SingleButtonType {
    case signIn
    case signUp
    case forgotPassword
    
    var text: String {
        switch self {
        case .signIn:
            return "Already Dara's user?"
        case .signUp:
            return "Not your member?"
        case .forgotPassword:
            return ""
        }
    }
    
    var link: String {
        switch self {
        case .signIn:
            return "Sign In"
        case .signUp:
            return "Sign Up"
        case .forgotPassword:
            return "Forgot your password?"
        }
    }
}

struct SingleButtonView: View {
    @Environment(\.router) var router
    
    let buttonType: SingleButtonType
    
    var body: some View {
        HStack (spacing: 7){
            Text(buttonType.text)
            
            Button {
                router.showScreen(.push) { router in
                    switch buttonType {
                    case .signIn:
                        SignInPage(viewModel: SignInViewModel(router: router))
                            .navigationBarBackButtonHidden()
                    case .signUp:
                        RegistrationPageView(viewModel: RegistrationPageViewModel(router: router))
                            .navigationBarBackButtonHidden()
                    case .forgotPassword:
                        ForgotPasswordPage(viewModel: ForgotPasswordViewModel(router: router))
                            .navigationBarBackButtonHidden()
                    }
                }
            } label: {
                Text(buttonType.link)
            }
        }
    }
}


#Preview {
    SingleButtonView(buttonType: .signIn)
}
