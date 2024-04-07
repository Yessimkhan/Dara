//
//  CardsForWords.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 01.03.2024.
//

import SwiftUI

struct CardsForWords: View {
    
    @State var isFlipped: Bool = false
    
    var body: some View {
        ZStack {
            myCard(text: "Yesso", color: .blue)
                .rotation3DEffect(
                    .degrees(isFlipped ? 0 : -90),
                                          axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .animation(isFlipped ? .linear.delay(0.35) : .linear, value: isFlipped)
            myCard(text: "Aza", color: .red)
                .rotation3DEffect(
                    .degrees(isFlipped ? 90 : 0),
                                          axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .animation(isFlipped ? .linear : .linear.delay(0.35), value: isFlipped)
        }
        .onTapGesture {
            withAnimation (.spring){
                isFlipped.toggle()
            }
        }
    }
}

struct myCard: View {
    
    var text: String
    var color: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 200, height: 300)
                .foregroundStyle(color)
            Text(text)
                .font(.title)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    CardsForWords()
}
