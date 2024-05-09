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
            VStack {
                ForEach(alphabetArray, id: \.self) { letter in
                    HStack (spacing: 60){
                        ZStack {
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(Colors.brandPrimary)
                                .frame(maxWidth: 200)
                                .frame(height: 165)
                            HStack () {
                                Text(String(letter).uppercased())
                                    .font(.system(size: 64))
                                    .padding()
                                Text(String(letter))
                                    .font(.system(size: 64))
                                    .padding()
                            }
                        }
                        
                        Image(systemName: "speaker.wave.2")
                            .resizable()
                            .frame( width: 60, height: 48)
                            .padding(.trailing, 24)
                    }
                }
            }
        }
        .navigationTitle("Alphabeet")
    }
}

#Preview {
    RouterView {router in
        AlphabeetPage(router: router)
    }
}
