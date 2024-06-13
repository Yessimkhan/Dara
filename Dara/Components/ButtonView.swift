//
//  ButtonView.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 04.04.2024.
//

import SwiftUI

import SwiftUI

enum ButtonType {
    case next
    case continueButton
    case finish
    case signIn
    case signUp
    case signOut
    case chooseYourLanguage
    case english
    case russian
    case submit
    case affirmative
    case negative
    case tryAgain
    case retry
    case check
    case custom
    case update
    
    var localizedString: LocalizedStringKey {
        switch self {
        case .next: return "Next"
        case .continueButton: return "Continue"
        case .finish: return "Finish"
        case .signIn: return "Sign In"
        case .signUp: return "Sign Up"
        case .signOut: return "Sign Out"
        case .chooseYourLanguage: return "Choose your Language"
        case .english: return "Eng"
        case .russian: return "Rus"
        case .submit: return "Submit"
        case .affirmative: return "True"
        case .negative: return "False"
        case .tryAgain: return "Try again"
        case .retry: return "Retry"
        case .check: return "Check"
        case .update: return "Update"
        case .custom: return ""
        }
    }
}

struct ButtonView: View {
    
    let buttonType: ButtonType
    let withBackground: Bool
    let buttonText: String
    @Binding var disabled: Bool
    
    init(buttonType: ButtonType, withBackground: Bool = true, buttonText: String = "", disabled: Binding<Bool> = .constant(false)) {
        self.buttonType = buttonType
        self.withBackground = withBackground
        self.buttonText = buttonText
        self._disabled = disabled
    }
    
    var body: some View {
        let displayText: Text
        if buttonType == .custom {
            displayText = Text(buttonText)
        } else {
            displayText = Text(buttonType.localizedString)
        }
        
        if withBackground {
            return displayText
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Colors.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(!disabled ? Colors.brandPrimary.cornerRadius(10) : Color.gray.cornerRadius(10))
                .lineLimit(nil)
                .eraseToAnyView()
        } else {
            return displayText
                .font(.system(size: 18, weight: .regular))
                .foregroundColor(Colors.brandPrimary)
                .padding()
                .frame(maxWidth: .infinity)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(Colors.brandPrimary))
                .lineLimit(nil)
                .eraseToAnyView()
        }
    }
}

extension View {
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
}


