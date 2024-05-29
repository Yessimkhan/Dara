//
//  LessonView.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 16.03.2024.
//

import SwiftUI

struct LessonView: View {
    
    let lessonDate: TopicsResponseElement
    let image: Image
    
    var body: some View {
        ZStack (alignment: .leading){
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Colors.brandPrimary)
                .frame(maxWidth: .infinity)
                .frame(height: 140)
            HStack(spacing: 25) {
                VStack {
                    Text("\(lessonDate.topicsResponseID - 1) - lesson")
                        .foregroundStyle(Colors.white)
                        .font(.system(size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(lessonDate.title)
                        .foregroundStyle(Colors.white)
                        .font(.system(size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(lessonDate.translation.title)
                        .foregroundStyle(Colors.white)
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(width: 160)
                .padding(.leading, 24)
                
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 115)
                    .padding(.trailing)
            }
        }
    }
}


//#Preview {
//    LessonView(lessonDate: TopicsResponseElement(numberOfLesson: 1, nameInKazakh: "", nameInAnotherLanguage: ""))
//}
