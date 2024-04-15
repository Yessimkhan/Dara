//
//  Matching.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 09.04.2024.
//

import SwiftUI

struct Matching: View {
    var body: some View {
        ZStack {
            VStack (spacing: 10){
                VStack(spacing: 16){
                    ZStack (alignment: .leading) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 342, height: 16)
                            .background(Color(red: 0.97, green: 0.97, blue: 0.95))
                            .cornerRadius(12)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 114, height: 16)
                            .background(Color(red: 0, green: 0.67, blue: 0.76))
                            .cornerRadius(12)
                    }
                    
                    Text("2/6")
                }
                
                
                VStack(alignment: .leading) {
                    Text("Дұрыс жауаппен сәйкестендір")
                    Text("Matching")
                        .font(.callout)
                    
                }
                
                HStack (spacing: 20){
                    VStack (spacing: 20){
                        MatchCards(text: "Сенің")
                        MatchCards(text: "Сенің")
                        MatchCards(text: "Сенің")
                    }
                    VStack (spacing: 20){
                        MatchCards(text: "Сенің")
                        MatchCards(text: "Сенің")
                        MatchCards(text: "Сенің")
                    }
                }
                
                Spacer(minLength: .minimum(0, 0))
                
                Button {
                    
                } label: {
                    ButtonView(buttonType: .continue)
                }
                
            }
        }
        .padding(24)
    }
}

struct MatchCards: View {
    let text: String
    @State var isSelected: Bool = false
    var body: some View {
        if !isSelected {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 160, height: 148)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 0.5)
                            .stroke(Colors.brandPrimary, lineWidth: 2)
                    )
                Text(text)
                    .font(.system(size: 18))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
            }
            .onTapGesture {
                withAnimation(.spring) {
                    isSelected.toggle()
                }
            }
        } else {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 160, height: 148)
                    .cornerRadius(12)
                    .background(Colors.brandPrimary.cornerRadius(12))
                    
                Text(text)
                    .font(.system(size: 18))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Colors.white)
            }
            .onTapGesture {
                withAnimation(.spring) {
                    isSelected.toggle()
                }
            }
        }
    }
}

#Preview {
    Matching()
}
