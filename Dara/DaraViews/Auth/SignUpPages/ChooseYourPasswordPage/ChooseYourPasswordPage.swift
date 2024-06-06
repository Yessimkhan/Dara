//
//  ChooseYourPasswordPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 05.04.2024.
//

import SwiftUI
import SwiftfulRouting

struct ChooseYourPasswordPage: View {
    
    @StateObject var viewModel: ChooseYourPasswordViewModel
    
    var body: some View {
        ZStack {
            VStack (spacing: 32) {
                Spacer()
                Text("Choose your password")
                    .font(.title)
                
                VStack(spacing: 64) {
                    VStack(spacing: 32) {
                        VStack(alignment: .leading, spacing: 16) {
                            
                            PasswordTextFieldView(isPasswordVisible: viewModel.isPasswordVisible, placeholder: "Password", text: $viewModel.password, isError: $viewModel.isError)
                                .onChange(of: viewModel.password) {
                                    viewModel.verifyPassword()
                                }
                                .hidden()
                            
                            
                            PasswordTextFieldView(isPasswordVisible: viewModel.isPasswordVisible, placeholder: "Password", text: $viewModel.password, isError: $viewModel.isError)
                                .onChange(of: viewModel.password) {
                                    viewModel.verifyPassword()
                                }
                            
                            PasswordTextFieldView(isPasswordVisible: viewModel.isConfirmPasswordVisible, placeholder: "Confirm password", text: $viewModel.confirmPassword, isError: $viewModel.isError)
                                .onChange(of: viewModel.confirmPassword) {
                                    viewModel.verifyPassword()
                                }
                            
                            if let message = viewModel.errorMessage {
                                Text(message)
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(Colors.wrongAnswer)
                            } else {
                                Text("space")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(.clear)
                            }
                        }
                        
                        Button {
                            viewModel.goChooseLevelPage()
                        } label: {
                            ButtonView(buttonType: .continue, disabled: $viewModel.verified)
                        }
                        .disabled(!viewModel.verified)
                    }
                    VStack(spacing: 16){
                        LoginWithGoogleAndFacebookView()
                        Button {
                            viewModel.goSignInPageView()
                        } label: {
                            SingleButtonView(buttonType: .signIn)
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 42)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    RouterView { router in
        ChooseYourPasswordPage(viewModel: ChooseYourPasswordViewModel(router: router, language: "", userName: "", userNumber: "", userEmail: ""))
    }
}
