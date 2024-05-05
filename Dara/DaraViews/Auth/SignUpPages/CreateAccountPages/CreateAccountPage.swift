//
//  CreateAccountPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 27.02.2024.
//

import SwiftUI
import SwiftfulRouting

struct CreateAccountPage: View {
    
    @State var userName: String = ""
    @State var userNumber: String = ""
    @State var userEmail: String = ""
    @StateObject var viewModel: CreateAccountViewModel
    
    var body: some View {
            ZStack {
                VStack (spacing: 74) {
                    Spacer()
                    
                    Text("Create an Account")
                        .font(.title)
                    
                    VStack(spacing: 64) {
                        VStack(spacing: 34) {
                            VStack(spacing: 18){
                                TextFieldView(placeholder: "Username", text: $userName, isError: $viewModel.isError)
                                
                                TextFieldView(placeholder: "Phone number", text: $userNumber, isError: $viewModel.isError)
                                
                                TextFieldView(placeholder: "Email", text: $userEmail, isError: $viewModel.isError)
                            }
                            
                            Button(action: {
                                viewModel.goChooseYourPassword()
                            }, label: {
                                ButtonView(buttonType: .continue)
                            })
                        }
                        VStack(spacing: 17){
                            LoginWithGoogleAndFacebookView()
                            SingleButtonView(buttonType: .signIn)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 42)
            }
        
    }
}

#Preview {
    RouterView { router in
        CreateAccountPage(viewModel: CreateAccountViewModel(router: router))
    }
}
