//
//  RegistrationPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 27.02.2024.
//

import SwiftUI

struct RegistrationPage: View {
    
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(systemName: "star.fill")
                    .font(.system(size: 100))
                    .foregroundColor(Color.green)
                VStack (spacing: 20) {
                    Spacer()
                    
                    NavigationLink {
                        ChoseLanguagePage()
                    } label: {
                        Text("Choose a language")
                            .foregroundStyle(Color.blue)
                            .padding()
                            .padding(.horizontal, 80)
                            .background(Color.black.cornerRadius(10))
                    }
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Alreary Dara's user? Log in")
                        
                    })
                }
            }
        }
    }
}

#Preview {
    RegistrationPage()
}
