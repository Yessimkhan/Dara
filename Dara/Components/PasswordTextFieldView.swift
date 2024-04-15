//
//  PasswordTextFieldView.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 05.04.2024.
//

import SwiftUI

struct PasswordTextFieldView: View {
    
    @State var isPasswordVisible: Bool = false
    var placeholder: String
    @Binding var text: String
    @Binding var isError: Bool
    
    var body: some View {
        HStack {
            if isPasswordVisible {
                PasswordTextField(
                    placeholder: placeholder,
                    text: $text,
                    isError: $isError
                )
            } else {
                PasswordSecuredTextField(
                    placeholder: placeholder,
                    text: $text,
                    isError: $isError
                )
            }
        }
        .onChange(of: text) {
            isError = false
        }
        .overlay(alignment: .trailing) {
            Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                .padding()
                .onTapGesture {
                    isPasswordVisible.toggle()
                }
                .offset(y: 15)
        }
        
    }
}

struct PasswordTextField: View {
    
    var placeholder: String
    @Binding var text: String
    @Binding var isError: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(placeholder)
            TextField(
                "\(placeholder)...",
                text: $text
            )
            .padding()
            .frame(height: 56)
            .background(Colors.textFieldBackground.cornerRadius(10))
            .addBorder(isError ? Color.red : Color.clear, width: isError ? 1 : 0, cornerRadius: 10)
        }
    }
}

struct PasswordSecuredTextField: View {
    
    var placeholder: String
    @Binding var text: String
    @Binding var isError: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(placeholder)
            SecureField(
                "\(placeholder)...",
                text: $text
            )
            .padding()
            .frame(height: 56)
            .background(Colors.textFieldBackground.cornerRadius(10))
            .addBorder(isError ? Color.red : Color.clear, width: isError ? 1 : 0, cornerRadius: 10)
        }
    }
}

