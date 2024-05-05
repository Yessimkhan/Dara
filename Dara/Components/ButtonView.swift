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
    case `true`
    case `false`
    case custom
    
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
        case .true: "True"
        case .false: "False"
        case .custom:
            "custom"
        }
    }
}

struct ButtonView: View {
    
    let buttonType: ButtonType
    let withBackground: Bool
    var buttonText: String
    
    init(buttonType: ButtonType, withBackground: Bool = false, buttonText: String = "") {
        self.buttonType = buttonType
        self.withBackground = withBackground
        self.buttonText = buttonText
    }
    
    var body: some View {
        if withBackground {
            Text(buttonType.type == "custom" ? buttonText : buttonType.type)
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(Colors.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Colors.brandPrimary.cornerRadius(10))
                .lineLimit(nil)
        }
        else {
            Text(buttonType.type == "custom" ? buttonText : buttonType.type)
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(Colors.brandPrimary)
                .padding()
                .frame(maxWidth: .infinity)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(Colors.brandPrimary))
                .lineLimit(nil)
        }
    }
}


#Preview {
    ButtonView(buttonType: .signIn, withBackground: true)
}
