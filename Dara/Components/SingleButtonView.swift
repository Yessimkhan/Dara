//
//  SingleButtonView.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 05.04.2024.
//

import SwiftUI

enum SingleButtonType {
    case signIn
    case signUp
    case forgotPassword
    
    var text: String {
        switch self {
        case .signIn:
            return "Already Dara's user?"
        case .signUp:
            return "Don't have an account"
        case .forgotPassword:
            return ""
        }
    }
    
    var link: String {
        switch self {
        case .signIn:
            return "Sign In"
        case .signUp:
            return "Sign Up"
        case .forgotPassword:
            return "Forgot your password?"
        }
    }
}

struct SingleButtonView: View {
    let buttonType: SingleButtonType
    
    var body: some View {
        HStack (spacing: 7){
            Text(buttonType.text)
                .foregroundStyle(Colors.black)
            Text(buttonType.link)
                .foregroundStyle(Colors.brandPrimary)
        }
    }
}


#Preview {
    SingleButtonView(buttonType: .signIn)
}
