//
//  LessonView.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 16.03.2024.
//

import SwiftUI

struct LessonView: View {
    
    let lessonDate: TopicsResponseElement
    let lessonId: Int
    let image: Image?
    @State var isLoading: Bool = true
    
    var body: some View {
        ZStack (alignment: .leading) {
            HStack(spacing: 25) {
                VStack(alignment: .leading) {
                    Text("\(lessonId) - lesson")
                        .foregroundStyle(Colors.white)
                        .font(.system(size: 14))
                    Text(lessonDate.title)
                        .foregroundStyle(Colors.white)
                        .font(.system(size: 24))
                    Text(lessonDate.translation?.title ?? "")
                        .foregroundStyle(Colors.white)
                        .font(.system(size: 16))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical)
                .padding(.leading, 24)
                
                if isLoading {
                    Spacer()
                    LoaderView()
                        .padding(.trailing, 48)
                }else {
                    image?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 115)
                        .padding(.trailing, 24)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: 140)
        .background(Colors.brandPrimary.cornerRadius(25))
        .onChange(of: image) {
            withAnimation {
                if image != nil {
                    isLoading = false
                } else {
                    isLoading = true
                }
            }
        }
    }
}


//#Preview {
//    LessonView(lessonDate: TopicsResponseElement(numberOfLesson: 1, nameInKazakh: "", nameInAnotherLanguage: ""))
//}
