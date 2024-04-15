//
//  ListenAndRepeatPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 09.04.2024.
//

import SwiftUI
import SwiftfulRouting
import AVKit

struct ListenAndRepeatPage: View {
    let router: AnyRouter
    
    var body: some View {
        ZStack {
            VStack (spacing: 32){
                VStack(spacing: 16){
                    ZStack (alignment: .leading) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 342, height: 16)
                            .background(Color(red: 0.97, green: 0.97, blue: 0.95))
                            .cornerRadius(12)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 57, height: 16)
                            .background(Color(red: 0, green: 0.67, blue: 0.76))
                            .cornerRadius(12)
                    }
                    
                    Text("1/6")
                }
                
                HStack() {
                    Image(systemName: "speaker.wave.2")
                        .resizable()
                        .frame( width: 25, height: 20)
                        .padding(.trailing, 24)
                        .onTapGesture {
                            SoundManager.instance.playSound(sound: .hello)
                        }
                    
                    VStack(alignment: .leading) {
                        Text("Тыңдаңыз және қайталаңыз.")
                        Text("Listen and repeat.")
                            .font(.callout)
                    }
                }
                
                Image("speak")
                VStack {
                    Text("Сәлем")
                        .font(.title)
                    Text("Hello")
                        .font(.title2)
                    
                }
                Spacer()
                
                Button {
                    router.showScreen(.push) { router in
                        Matching()
                    }
                } label: {
                    ButtonView(buttonType: .continue)
                }

            }
        }
        .padding(24)
    }
}

#Preview {
    RouterView { router in
        ListenAndRepeatPage(router: router)
    }
}
