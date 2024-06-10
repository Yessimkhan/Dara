//
//  ForgotPasswordPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 06.04.2024.
//

import SwiftUI
import SwiftfulRouting

struct ForgotPasswordPage: View {
    
    @StateObject var viewModel: ForgotPasswordViewModel
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                LoaderView()
            }
            VStack (spacing: 166) {
                Spacer()
                VStack(spacing: 74) {
                    Text("Forgot password?")
                        .font(.title)
                    
                    VStack(alignment: .leading , spacing: 32) {
                        Text("Don’t worry! It happens. Please enter the address associated with your account.")
                            .lineLimit(nil)
                            .font(.system(size: 16, weight: .regular))
                            .fixedSize(horizontal: false, vertical: true)
                        
                        TextFieldView(placeholder: "Email", text: $viewModel.email, isError: $viewModel.isError)
                            .onChange(of: viewModel.email) {
                                viewModel.verifyEmail()
                            }
                            .keyboardType(.emailAddress)
                    }
                }
                Button {
                    viewModel.sendEmail()
                } label: {
                    ButtonView(buttonType: .submit, disabled: $viewModel.isDisabled)
                }
            }
            .blur(radius: viewModel.isLoading ? 3 : 0)
            .padding(.horizontal, 24)
            .padding(.bottom, 194)   
        }
        .alert(isPresented: $viewModel.showMessage, content: {
            Alert(title: Text(viewModel.message))
        })
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
        .environment(\.locale, Locale(identifier: viewModel.userLanguage))
    }
}

#Preview {
    RouterView { router in
        ForgotPasswordPage(viewModel:ForgotPasswordViewModel(router: router))
    }
}
