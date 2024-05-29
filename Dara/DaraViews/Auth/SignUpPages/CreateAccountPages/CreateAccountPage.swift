//
//  CreateAccountPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 27.02.2024.
//

import SwiftUI
import SwiftfulRouting

struct CreateAccountPage: View {
    
    @StateObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        ZStack {
            VStack (spacing: 32) {
                Spacer()
                Text("Create an Account")
                    .font(.title)
                
                VStack(spacing: 64) {
                    VStack(spacing: 32) {
                        VStack(alignment: .leading, spacing: 16) {
                            TextFieldView(placeholder: "Username", text: $viewModel.userName, isError: $viewModel.isError)
                                .onChange(of: viewModel.userName) {
                                    viewModel.verifyUsername()
                                }
                            
                            PhoneTextFieldView(placeholder: "Phone number", text: $viewModel.userNumber, isError: $viewModel.isError)
                                .onChange(of: viewModel.userNumber) {
                                    viewModel.verifyPhone()
                                }
                            TextFieldView(placeholder: "Email", text: $viewModel.userEmail, isError: $viewModel.isError)
                                .onChange(of: viewModel.userEmail) {
                                    viewModel.verifyEmail()
                                }
                                .keyboardType(.emailAddress)
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
                            viewModel.goChooseYourPassword()
                        } label: {
                            if !viewModel.verified {
                                ButtonView(buttonType: .continue, disabled: true)
                            } else {
                                ButtonView(buttonType: .continue, disabled: false)
                            }
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
        CreateAccountPage(viewModel: CreateAccountViewModel(router: router, language: "en"))
    }
}
