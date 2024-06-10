//
//  PersonalInformationPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 10.06.2024.
//

import SwiftUI
import SwiftfulRouting

struct PersonalInformationPage: View {
    
    @StateObject var viewModel: PersonalInformationViewModel
    
    var body: some View {
        ZStack {
            VStack (spacing: 32) {
                
                Text("Personal Information")
                    .font(.title)
                
                VStack(spacing: 32) {
                    VStack(alignment: .leading, spacing: 16) {
                        TextFieldView(placeholder: "Username", text: $viewModel.userNameF, isError: $viewModel.isError)
                            .onChange(of: viewModel.userNameF) {
                                viewModel.verifyUsername()
                            }
                        
                        PhoneTextFieldView(placeholder: "Phone number", text: $viewModel.userPhoneF, isError: $viewModel.isError)
                            .onChange(of: viewModel.userPhoneF) {
                                viewModel.verifyPhone()
                            }
                        
                        TextFieldView(placeholder: "Email", text: $viewModel.userEmailF, isError: $viewModel.isError)
                            .onChange(of: viewModel.userEmailF) {
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
                        viewModel.updatePersonalInformation()
                    } label: {
                        ButtonView(buttonType: .submit, disabled: $viewModel.verified)
                    }
                    .disabled(viewModel.verified)
                }
                
            }
            .alert(isPresented: $viewModel.showMessage, content: {
                Alert(title: Text(viewModel.message))
            })
            .blur(radius: viewModel.isLoading ? 3 : 0)
            .padding(.horizontal, 24)
            .padding(.bottom, 42)
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
        .ignoresSafeArea()
    }
}

#Preview {
    RouterView { router in
        PersonalInformationPage(viewModel: PersonalInformationViewModel(router: router))
    }
}
