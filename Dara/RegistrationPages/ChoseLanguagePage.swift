//
//  ChoseLanguagePage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 27.02.2024.
//

import SwiftUI

struct ChoseLanguagePage: View {
    var body: some View {
        NavigationStack {
            VStack (spacing: 40) {
                Image(systemName: "star.fill")
                    .font(.system(size: 100))
                    .foregroundColor(Color.green)
                HStack {
                    
                    NavigationLink {
                        CreateAccountPage()
                    } label: {
                        Text("Eng")
                            .padding()
                            .padding(.horizontal, 50)
                            .background(Color.black.cornerRadius(10))
                    }

                    NavigationLink {
                        CreateAccountPage()
                    } label: {
                        Text("Rus")
                            .padding()
                            .padding(.horizontal, 50)
                            .background(Color.black.cornerRadius(10))
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ChoseLanguagePage()
}
