//
//  LoginWithGoogleAndFacebookView.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 05.04.2024.
//

import SwiftUI

struct LoginWithGoogleAndFacebookView: View {
    
    @Environment(\.router) var router
    
    var body: some View {
        VStack (spacing: 20) {
            HStack (spacing: 15){
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 0.8)
                    .frame(maxWidth: .infinity)
                    .background(Colors.black.opacity(0.2))
                Text("Or")
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 0.8)
                    .frame(maxWidth: .infinity)
                    .background(Colors.black.opacity(0.2))
            }
            
            HStack {
                Button(action: {
                    // Action for the first button
                }, label: {
                    Images.facebookIcon
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Colors.textFieldBackground.cornerRadius(10))
                })
                
                Button(action: {
                    // Action for the second button
                }, label: {
                    Images.googleIcon
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Colors.textFieldBackground.cornerRadius(10))
                    
                })
            }
        }
        
    }
}


#Preview {
    LoginWithGoogleAndFacebookView()
}
