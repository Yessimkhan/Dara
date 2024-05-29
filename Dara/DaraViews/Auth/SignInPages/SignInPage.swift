//
//  SignInPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 01.03.2024.
//

import SwiftUI
import SwiftfulRouting

struct SignInPage: View {
    @StateObject var viewModel: SignInViewModel

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                LoaderView()
            }

            VStack(spacing: 64) {
                Spacer()
                Text("Sign In")
                    .font(.title)
                
                VStack(spacing: 86) {
                    VStack(alignment: .leading, spacing: 18) {
                        TextFieldView(placeholder: "Email address", text: $viewModel.email, isError: $viewModel.isError)
                            .submitLabel(.done)
                            .keyboardType(.emailAddress)
                        PasswordTextFieldView(placeholder: "Password", text: $viewModel.password, isError: $viewModel.isError)
                            .submitLabel(.done)
                        if viewModel.isError {
                            Text("Email or Password is Incorrect")
                                .foregroundStyle(Colors.wrongAnswer)
                        }
                        
                        Button {
                            viewModel.goForgotPasswordPage()
                        } label: {
                            SingleButtonView(buttonType: .forgotPassword)
                        }
                    }
                    
                    Button {
                        viewModel.signInButtonTapped()
                    } label: {
                        ButtonView(buttonType: .signIn)
                    }
                }
                VStack(spacing: 16) {
                    LoginWithGoogleAndFacebookView()
                    Button {
                        viewModel.goRegistrationPage()
                    } label: {
                        SingleButtonView(buttonType: .signUp)
                    }
                }
            }
        }
        .blur(radius: viewModel.isLoading ? 3 : 0)
        .padding(.horizontal, 24)
        .padding(.bottom, 42)
    }
}


#Preview {
    RouterView { router in
        SignInPage(viewModel: SignInViewModel(router: router))
    }
}
