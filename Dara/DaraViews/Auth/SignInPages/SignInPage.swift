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
    
    @FocusState private var focusedField: Field?
    
    enum Field {
        case email
        case password
    }
    
    var body: some View {
        ZStack {
            VStack (spacing: 16){
                VStack(spacing: 64) {
                    Text("Sign In")
                        .font(.title)
                    
                    VStack(alignment: .leading, spacing: 18) {
                        TextFieldView(placeholder: "Username or Email", text: $viewModel.email, isError: $viewModel.isError)
                            .submitLabel(.next)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .focused($focusedField, equals: .email)
                            .onSubmit {
                                focusedField = .password
                            }
                        
                        PasswordTextFieldView(placeholder: "Password", text: $viewModel.password, isError: $viewModel.isError)
                            .submitLabel(.done)
                            .focused($focusedField, equals: .password)
                            .onSubmit {
                                viewModel.signInButtonTapped()
                            }
                        
                        if viewModel.isError, let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundStyle(Colors.wrongAnswer)
                        }
                        
                        Button {
                            viewModel.goForgotPasswordPage()
                        } label: {
                            SingleButtonView(buttonType: .forgotPassword)
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                
                VStack(spacing: 16) {
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
