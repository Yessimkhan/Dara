//
//  TextFieldView.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 06.04.2024.
//

import SwiftUI

struct TextFieldView: View {
    
    @State var placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(placeholder)
            TextField("\(placeholder)...", text: $text)
                .padding()
                .background(Colors.textFieldBackground.cornerRadius(10))
        }
    }
}

