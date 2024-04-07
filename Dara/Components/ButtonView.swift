//
//  ButtonView.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 04.04.2024.
//

import SwiftUI

enum ButtonType {
    case next
    case `continue`
    case signIn
    case signUp
    case signOut
    case choseYourLanguage
    case eng
    case rus
    case submit
    
    var type: String {
        switch self {
        case .next: "Next"
        case .continue: "Continue"
        case .signIn: "Sign In"
        case .signUp: "Sign Up"
        case .signOut: "Sign Out"
        case .choseYourLanguage: "Choose your Language"
        case .eng: "Eng"
        case .rus: "Rus"
        case .submit: "Sumbit"
        }
    }
}

struct ButtonView: View {
    
    let buttonType: ButtonType
    
    var body: some View {
        Text(buttonType.type)
            .font(.system(size: 18, weight: .regular))
            .foregroundStyle(Colors.brandPrimary)
            .padding()
            .frame(maxWidth: .infinity)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(Colors.brandPrimary))
        
    }
}


#Preview {
    ButtonView(buttonType: .signIn)
}
