//
//  ForgotPasswordPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 06.04.2024.
//

import SwiftUI
import SwiftfulRouting

struct ForgotPasswordPage: View {
    
    @State var email: String = ""
    @StateObject var viewModel: ForgotPasswordViewModel
    
    var body: some View {
        ZStack {
            VStack (spacing: 166) {
                Spacer()
                VStack(spacing: 74) {
                    Text("Forgot password?")
                        .font(.title)
                    
                    VStack(alignment: .leading , spacing: 32) {
                        Text("Don’t worry! It happens. Please enter the address associated with your account.")
                            .lineLimit(2)
                            .font(.system(size: 16, weight: .regular))
                            .fixedSize(horizontal: false, vertical: true)
                        
                        TextFieldView(placeholder: "Email adress", text: $email, isError: $viewModel.isError)
                    }
                }
                Button {
                    viewModel.goResetPasswordPage()
                } label: {
                    ButtonView(buttonType: .continue)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 194)   
        }
    }
}

#Preview {
    RouterView { router in
        ForgotPasswordPage(viewModel:ForgotPasswordViewModel(router: router))
    }
}
