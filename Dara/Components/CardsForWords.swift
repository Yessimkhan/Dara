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
            withAnimation (.spring){
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
        ZStack (){
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 340, height: 260)
                .foregroundStyle(color)
            
            VStack {
                if color == Colors.white {
                    Images.blueTop
                        .resizable()
                        .frame(width: 334, height: 53)
                        .offset(y: -8 )
                } else {
                    Images.whiteTop
                        .resizable()
                        .frame(width: 334, height: 53)
                        .offset(y: -8 )
                }
                if let image = image {
                    image
                        .resizable()
                        .frame(width: 157, height: 99)
                        .cornerRadius(12)
                } else {
                    LoaderView()
                        .frame(height: 99)
                }
                
                Text(text)
                    .font(.title)
                    .fontWeight(.semibold)
            }
        }
        .overlay(RoundedRectangle(cornerRadius: 24).stroke(lineWidth: 2).foregroundColor(Colors.brandPrimary))
    }
}

#Preview {
//    CardsForWords(title: "Yesso", translate: "Aza", image: Images.eaglesImage)
    CardsForWords(title: "Yesso", translate: "Aza")
}
