//
//  ChangePasswordPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 06.04.2024.
//

import SwiftUI
import SwiftfulRouting

struct ChangePasswordPage: View {
    
    @StateObject var viewModel: ChangePasswordViewModel
    
    var body: some View {
        ZStack {
            VStack (spacing: 166) {
                Spacer()
                VStack(spacing: 74) {
                    Text("Change Password")
                        .font(.title)
                    
                    VStack(alignment: .leading , spacing: 18) {
                        PasswordTextFieldView(isPasswordVisible: viewModel.isPasswordVisible, placeholder: "Current password", text: $viewModel.currernPassword, isError: $viewModel.isError)
                            .onChange(of: viewModel.currernPassword) {
                                viewModel.verifyPassword()
                            }
                        
                        PasswordTextFieldView(isPasswordVisible: viewModel.isPasswordVisible, placeholder: "New password", text: $viewModel.password, isError: $viewModel.isError)
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
                Button {
                    viewModel.changePassword()
                } label: {
                    ButtonView(buttonType: .submit, disabled: $viewModel.isDisabled)
                }
            }
            .alert(isPresented: $viewModel.showMessage, content: {
                Alert(title: Text(viewModel.message))
            })
            .blur(radius: viewModel.isLoading ? 3 : 0)
            .padding(.horizontal, 24)
            .padding(.bottom, 194)
            
            if viewModel.isLoading {
                LoaderView()
            }
        }
        .toolbar {
            ToolbarItem (placement: .topBarTrailing) {
                Button {
                    viewModel.router.dismissScreen()
                } label: {
                    Image(systemName: "xmark")
                        .fontWeight(.semibold)
                }
            }
        }
        .environment(\.locale, Locale(identifier: viewModel.userLanguage))
    }
}

#Preview {
    RouterView { router in
        ChangePasswordPage(viewModel: ChangePasswordViewModel(router: router))
    }
}
