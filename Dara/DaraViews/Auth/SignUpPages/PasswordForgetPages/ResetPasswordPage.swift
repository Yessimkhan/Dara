//
//  ResetPasswordPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 06.04.2024.
//

import SwiftUI
import SwiftfulRouting

struct ResetPasswordPage: View {
    
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var isPasswordVisible: Bool = false
    @State var isConfirmPasswordVisible: Bool = false
    @StateObject var viewModel: ForgotPasswordViewModel
    
    var body: some View {
        ZStack {
            VStack (spacing: 166) {
                Spacer()
                VStack(spacing: 74) {
                    Text("Reset password?")
                        .font(.title)
                    
                    VStack(alignment: .leading , spacing: 18) {
//                        PasswordTextFieldView(isPasswordVisible: $isPasswordVisible, placeholder: "Password", text: $password) { changed in
//                        }
                        
//                        PasswordTextFieldView(isPasswordVisible: $isConfirmPasswordVisible, placeholder: "Confirm password", text: $confirmPassword) { changed in
//                            
//                        }
                    }
                }
                Button {
                    viewModel.goMainTabBar()
                } label: {
                    ButtonView(buttonType: .submit)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 194)
        }
    }
}

#Preview {
    RouterView { router in
        ResetPasswordPage(viewModel:ForgotPasswordViewModel(router: router))
    }
}
