//
//  DeleteAccountPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 13.06.2024.
//

import SwiftUI
import SwiftfulRouting

struct DeleteAccountPage: View {
    
    @StateObject var viewModel: DeleteAccountViewModel
    
    var body: some View {
        
        ZStack {
            VStack (spacing: 16) {
                Images.eaglesImage
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                
                Text("Are you sure you want to delete your account? This action is irreversible and cannot be undone. Once your account is deleted, you will permanently lose access to all your data and any content associated with your account.")
                
                Text("To confirm, please enter your username in the field below. If the username matches, you will be able to tap the 'Delete My Account' button.")
                
                TextFieldView(placeholder: "Username", text: $viewModel.username, isError: $viewModel.isError)
                    .onChange(of: viewModel.username) {
                        viewModel.checkUsername()
                    }
                
                Spacer(minLength: 0)
                
                Button {
                    viewModel.deleteAccount()
                } label: {
                    Text("Delete My Account")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Colors.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(!viewModel.disabled ? Colors.wrongAnswer.cornerRadius(10) : Color.gray.cornerRadius(10))
                }
                .disabled(viewModel.disabled)
            }
            .blur(radius: viewModel.isLoading ? 3 : 0)
            
            if viewModel.isLoading {
                LoaderView()
            }
        }
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
        .alert(
            viewModel.message,
            isPresented: $viewModel.showMessage,
            actions: {
                Button("OK"){}
            }
        )
        .environment(\.locale, Locale(identifier: viewModel.userLanguage))
        .padding(.horizontal, 24)
        .padding(.vertical, 42)
    }
    
    
}

#Preview {
    RouterView { router in
        DeleteAccountPage(viewModel: DeleteAccountViewModel(router: router))
    }
}
