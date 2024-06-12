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
            ZStack {
                VStack(spacing: 64) {
                    Text("Sign In")
                        .font(.title)
                    
                    VStack(spacing: 64) {
                        VStack(alignment: .leading, spacing: 18) {
                            TextFieldView(placeholder: "Username or Email", text: $viewModel.email, isError: $viewModel.isError)
                                .submitLabel(.done)
                                .keyboardType(.emailAddress)
                            
                            PasswordTextFieldView(placeholder: "Password", text: $viewModel.password, isError: $viewModel.isError)
                                .submitLabel(.done)
                            
                            Button {
                                viewModel.goForgotPasswordPage()
                            } label: {
                                SingleButtonView(buttonType: .forgotPassword)
                            }
                            
                            if viewModel.isError {
                                Text(viewModel.errorMessage ?? "")
                                    .foregroundStyle(Colors.wrongAnswer)
                            } else {
                                Text("space")
                                    .foregroundStyle(Color.clear)
                            }
                        }
                    }
                }
                VStack(spacing: 16) {
                    Spacer()
                    Button {
                        viewModel.signInButtonTapped()
                    } label: {
                        ButtonView(buttonType: .signIn)
                    }
                    
                    Button {
                        viewModel.goRegistrationPage()
                    } label: {
                        SingleButtonView(buttonType: .signUp)
                    }
                }
            }
            .blur(radius: viewModel.isLoading ? 3 : 0)
            
            if viewModel.isLoading {
                LoaderView()
            }
        }
        .environment(\.locale, Locale(identifier: viewModel.userLanguage))
        .padding(.horizontal, 24)
        .padding(.bottom, 42)
    }
}


#Preview {
    RouterView { router in
        SignInPage(viewModel: SignInViewModel(router: router))
    }
}
