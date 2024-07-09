//
//  CardsForWords.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 01.03.2024.
//

import SwiftUI

struct CardsForWords: View {
    
    @State var isFlipped: Bool = true
    var title: String
    var translate: String
    var image: Image?
    
    var body: some View {
        ZStack {
            myCard(text: title, color: Colors.white, image: image)
                .rotation3DEffect(
                    .degrees(isFlipped ? 0 : -90),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .animation(isFlipped ? .linear.delay(0.35) : .linear, value: isFlipped)
            myCard(text: translate, color: Colors.brandPrimary, image: image)
                .rotation3DEffect(
                    .degrees(isFlipped ? 90 : 0),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .animation(isFlipped ? .linear : .linear.delay(0.35), value: isFlipped)
        }
        .onTapGesture {
            withAnimation (.spring) {
                isFlipped.toggle()
            }
        }
    }
}

struct myCard: View {
    
    var text: String
    var color: Color
    var image: Image?
    
    var body: some View {
        ZStack {
            VStack {
                (color == Colors.white ? Images.blueTop : Images.whiteTop)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                if let image = image {
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .frame(maxWidth: 300, maxHeight: 200)

                } else {
                    LoaderView()
                        .frame(height: 200)
                }
                
                Text(text)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(color == Colors.white ? Colors.brandPrimary : Colors.white)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal)
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal)
        .background(color)
        .cornerRadius(24)
        .overlay(RoundedRectangle(cornerRadius: 24).stroke(lineWidth: 2).foregroundColor(Colors.brandPrimary))
    }
}

#Preview {
        CardsForWords(title: "АҚШ (Америка Құрама Штаттары)", translate: "USA (United States of America)", image: Image("speak"))
//    CardsForWords(title: "Yesso", translate: "Aza")
}
