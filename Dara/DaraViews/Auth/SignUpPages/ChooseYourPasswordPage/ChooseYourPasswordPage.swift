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
    @AppStorage("userLanguage") var userLanguage: String = NSLocale.current.language.languageCode?.identifier ?? "en"
    
    var body: some View {
        ZStack {
            VStack (spacing: 32) {
                Text("Choose your password")
                    .font(.title)
                
                VStack(alignment: .leading, spacing: 16) {
                    PasswordTextFieldView(isPasswordVisible: viewModel.isPasswordVisible, placeholder: "Password", text: $viewModel.password, isError: $viewModel.isError)
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
            }
            
            VStack(spacing: 16) {
                Spacer()
                
                Button {
                    viewModel.goChooseLevelPage()
                } label: {
                    ButtonView(buttonType: .continueButton, disabled: $viewModel.verified)
                }
                .disabled(viewModel.verified)
                
                Button {
                    viewModel.router.dismissScreenStack()
                } label: {
                    SingleButtonView(buttonType: .signIn)
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 42)
        .toolbar {
            ToolbarItem (placement: .topBarLeading) {
                Button {
                    viewModel.router.dismissScreen()
                } label: {
                    Image(systemName: "chevron.left")
                        .fontWeight(.semibold)
                }
            }
        }
        .environment(\.locale, Locale(identifier: userLanguage))
        .ignoresSafeArea()
    }
}

#Preview {
    RouterView { router in
        ChooseYourPasswordPage(viewModel: ChooseYourPasswordViewModel(router: router, language: "", userName: "", userNumber: "", userEmail: ""))
    }
}
