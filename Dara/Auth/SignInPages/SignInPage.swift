//
//  SignInPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 01.03.2024.
//

import SwiftUI
import SwiftfulRouting

struct SignInPage: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var isPasswordVisible: Bool = false
    @State var isConfirmPasswordVisible: Bool = false
    @StateObject var viewModel: SignInViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 64) {
                Spacer()
                Text("Sign In")
                    .font(.title)
                
                VStack (spacing: 86) {
                    VStack (alignment: .leading, spacing: 18) {
                        TextFieldView(placeholder: "Email adress", text: $email)
                        
                        PasswordTextFieldView(
                            isPasswordVisible: $isPasswordVisible,
                            placeholder: "Password",
                            text: $password,
                            isTextChanged: { (changed) in
                                
                            }
                        )
                        SingleButtonView(buttonType: .forgotPassword)
                    }
                    
                    Button {
                        viewModel.goMenuTabBar()
                    } label: {
                        ButtonView(buttonType: .signIn)
                    }
                }
                VStack(spacing: 16) {
                    LoginWithGoogleAndFacebookView()
                    
                    SingleButtonView(buttonType: .signUp)
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 42)
    }
}


#Preview {
    RouterView { router in
        SignInPage(viewModel: SignInViewModel(router: router))
    }
}
