//
//  LessonView.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 16.03.2024.
//

import SwiftUI

struct LessonView: View {
    
    let numberOfLesson: Int
    let nameInKazakh: String
    let nameInAnotherLanguage: String
    
    var body: some View {
        ZStack (alignment: .leading){
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.gray)
                .frame(width: 342, height: 140)
            HStack(spacing: 30) {
                VStack {
                    Text("\(numberOfLesson) lesson")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(nameInKazakh)
                        .font(.title.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(nameInAnotherLanguage)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(width: 173)
                .padding(.leading)
                RoundedRectangle(cornerRadius: 12.0)
                    .fill(Color.black)
                    .frame(width: 110, height: 115)
                    .padding(.trailing)
            }
        }
    }
}

#Preview {
    LessonView(numberOfLesson: 1, nameInKazakh: "Yessimkhan", nameInAnotherLanguage: "Yesso")
}
