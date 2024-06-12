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
    @AppStorage("userLanguage") var userLanguage: String = NSLocale.current.language.languageCode?.identifier ?? "en"
    
    var body: some View {
        ZStack {
            VStack (spacing: 32) {
                
                Text("Create an Account")
                    .font(.title)
                
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
            }
            
            VStack(spacing: 16){
                Spacer()
                
                Button {
                    viewModel.goChooseYourPassword()
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
        CreateAccountPage(viewModel: CreateAccountViewModel(router: router, language: "en"))
    }
}
