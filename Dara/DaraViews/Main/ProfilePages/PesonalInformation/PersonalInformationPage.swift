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
                    ButtonView(buttonType: .update, disabled: $viewModel.verified)
                }
                .disabled(viewModel.verified)
                
                HStack {
                    Button {
                        viewModel.showDeleteAccountAlert()
                    } label: {
                        Text("Delete account")
                            .foregroundStyle(Colors.wrongAnswer)
                    }
                    Spacer()
                    if let url =  URL(string: "https://docs.google.com/document/d/113Fi4N1rcU3GAFFPWegZBu75jqay3ZfGuMdct-w8VJg") {
                        Button {
                            viewModel.router.showSafari {
                                url
                            }
                        } label: {
                            Text("Privacy Policy")
                                .foregroundStyle(Colors.brandPrimary)
                        }
                    }
                }
                .padding(.horizontal)
                
            }
            .alert(isPresented: $viewModel.showDeleteMessage) {
                Alert(
                    title: Text(viewModel.deleteMessage),
                    primaryButton: .destructive(Text("Delete"), action: {
                        viewModel.deleteAccount()
                    }),
                    secondaryButton: .default(Text("Cancel"))
                )
            }
            .alert(
                viewModel.message,
                isPresented: $viewModel.showMessage,
                actions: {
                    Button("OK"){}
                }
            )
            .blur(radius: viewModel.isLoading ? 3 : 0)
            .padding(.horizontal, 24)
            
            if viewModel.isLoading {
                LoaderView()
            }
        }
        .disabled(viewModel.isLoading)
        .environment(\.locale, Locale(identifier: viewModel.userLanguage))
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
    }
}

#Preview {
    RouterView { router in
        PersonalInformationPage(viewModel: PersonalInformationViewModel(router: router))
    }
}
