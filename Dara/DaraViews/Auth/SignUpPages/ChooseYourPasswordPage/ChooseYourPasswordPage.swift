//
//  ChooseYourPasswordPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 05.04.2024.
//

import SwiftUI
import SwiftfulRouting

struct ChooseYourPasswordPage: View {
    
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var isPasswordVisible: Bool = false
    @State var isConfirmPasswordVisible: Bool = false
    @StateObject var viewModel: ChooseYourPasswordViewModel
    
    var body: some View {
        VStack(spacing: 74) {
            Spacer()
            Text("Choose your password")
                .font(.title)
            VStack(spacing: 64){
                VStack(spacing: 132) {
                    VStack(spacing: 18) {
                        PasswordTextFieldView(isPasswordVisible: isPasswordVisible, placeholder: "Password", text: $password, isError: $viewModel.isError)
                        
                        PasswordTextFieldView(isPasswordVisible: isConfirmPasswordVisible, placeholder: "Confirm password", text: $confirmPassword, isError: $viewModel.isError) 
                    }
                    
                    Button {
                        viewModel.goChooseLevelPage()
                    } label: {
                        ButtonView(buttonType: .signUp)
                    }
                }
                
                VStack(spacing: 17){
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
}

#Preview {
    RouterView { router in
        ChooseYourPasswordPage(viewModel: ChooseYourPasswordViewModel(router: router))
    }
}
