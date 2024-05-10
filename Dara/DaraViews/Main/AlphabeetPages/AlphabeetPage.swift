//
//  AlphabeetPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 16.03.2024.
//

import SwiftUI
import SwiftfulRouting

struct AlphabeetPage: View {
    let router: AnyRouter
    
    let alphabetArray: [Character] = Array("аәбвгғдежзийкқлмнңоөпрстуұүфхһцчшщъыіьэюя")
    
    var body: some View {
        ScrollView (showsIndicators: false){
            VStack (spacing: 16){
                ForEach(alphabetArray, id: \.self) { letter in
                    HStack (spacing: 60){
                        
                        Image(systemName: "speaker.wave.2")
                            .resizable()
                            .frame( width: 40, height: 32)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(Colors.black)
                            )
                        
                        ZStack {
                            HStack (spacing: 16) {
                                Text(String(letter).uppercased())
                                    .font(.system(size: 56))
                                Text(String(letter))
                                    .font(.system(size: 56))
                            }
                            .frame(width: 150)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(Colors.brandPrimary)
                            )
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Alphabeet")
    }
}

#Preview {
    RouterView {router in
        AlphabeetPage(router: router)
    }
}
