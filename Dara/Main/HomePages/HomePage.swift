//
//  HomePage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 13.03.2024.
//

import SwiftUI

struct HomePage: View {
    
    @State var numberOfLesson: Int = 1
    @State var nameInKazakh: String = ""
    @State var nameInAnotherLanguage: String = ""
    
    
    var body: some View {
        NavigationStack {
            ScrollView (showsIndicators: false){
                VStack (spacing: 10){
                    
                    LessonView(
                        numberOfLesson: 1,
                        nameInKazakh: "Әліппе",
                        nameInAnotherLanguage: "Alphabet")
                    
                    LessonView(
                        numberOfLesson: 2,
                        nameInKazakh: "Сәлем",
                        nameInAnotherLanguage: "Hello")
                    
                    LessonView(
                        numberOfLesson: 3,
                        nameInKazakh: "Қалайсың",
                        nameInAnotherLanguage: "How are you?")
                    
                    LessonView(
                        numberOfLesson: 4,
                        nameInKazakh: "Қай елденсің ?",
                        nameInAnotherLanguage: "Where are you from?")
                    
                    LessonView(
                        numberOfLesson: 5,
                        nameInKazakh: "Сандар",
                        nameInAnotherLanguage: "Numbers")
                    
                }
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomePage()
}
