//
//  LessonHintPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 09.04.2024.
//

import SwiftUI
import SwiftfulRouting

struct LessonHintPage: View {
    
    let router: AnyRouter
    
    var body: some View {
        VStack (spacing: 50){
            Images.eaglesImage
            
            
            
            Image("hint")
            Spacer()
            Button {
                router.showScreen(.push) { router in
                    ListenAndRepeatPage(router: router)
                        .navigationTitle("Listen and Repeat")
                }
            } label: {
                ButtonView(buttonType: .continue)
            }

        }
        .padding(24)
    }
}

#Preview {
    RouterView { router in
        LessonHintPage(router: router)
    }
    
}
