//
//  TextFieldView.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 13.04.2024.
//

import SwiftUI

// Extension for adding border to any View with rounded corners.
extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
            .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}

struct TextFieldView: View {
    
    var placeholder: LocalizedStringResource
    @Binding var text: String
    @Binding var isError: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(placeholder)
            TextField("\(placeholder)...", text: $text)
                .padding()
                .frame(height: 56)
                .background(Colors.textFieldBackground.cornerRadius(10))
                .addBorder(isError ? Color.red : Color.clear, width: isError ? 1 : 0, cornerRadius: 10)
                .onChange(of: text) {
                    isError = false
                }
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    @State static var text = ""
    @State static var isError = true
    
    static var previews: some View {
        TextFieldView(placeholder: "Yesso", text: $text, isError: $isError)
    }
}

