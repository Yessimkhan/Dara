//
//  PhoneTextFieldView.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 29.05.2024.
//

import SwiftUI
import iPhoneNumberField

struct PhoneTextFieldView: View {
    
    var placeholder: LocalizedStringResource
    @Binding var text: String
    @Binding var isError: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(placeholder)
            iPhoneNumberField(text: $text)
                .flagHidden(false)
                .prefixHidden(false)
                .autofillPrefix(true)
                .flagSelectable(true)
                .padding()
                .background(Colors.textFieldBackground.cornerRadius(10))
                .addBorder(isError ? Color.red : Color.clear, width: isError ? 1 : 0, cornerRadius: 10)
                .onChange(of: text) {
                    isError = false
                }
        }
    }
}

struct PhoneTextFieldView_Previews: PreviewProvider {
    @State static var text = ""
    @State static var isError = false
    
    static var previews: some View {
        PhoneTextFieldView(placeholder: "Yesoo", text: $text, isError: $isError)
    }
}
