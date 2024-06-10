//
//  HomePage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 13.03.2024.
//

import SwiftUI
import SwiftfulRouting

struct HomePage: View {
    
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                LoaderView()
            } else {
                ScrollView (showsIndicators: false) {
                    VStack(spacing: 10) {
                        if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                        }
                        ForEach(Array(viewModel.lessonsArray.enumerated()), id: \.element.id) { index, lesson in
                            LessonView(lessonDate: lesson,lessonId: index + 1, image: viewModel.imagesArray[index])
                                .onTapGesture {
                                    viewModel.router.showScreen(.push) { router in
                                        LessonModulesPage(viewModel: LessonModuleViewModel(router: router, lessonId: lesson.topicsResponseID, lessonName: lesson.title))
                                            .navigationBarTitle(lesson.title, displayMode: .inline)
                                            .toolbar(.hidden, for: .tabBar)
                                            .navigationBarBackButtonHidden()
                                    }
                                }
                        }
                    }
                    .onChange(of: viewModel.userLevel) {
                        print(viewModel.userLevel)
                        print("get Lesson because user changed level")
                        viewModel.getLessons()
                    }
                    .onChange(of: viewModel.userLanguage) {
                        print(viewModel.userLevel)
                        print("get Lesson because user changed language")
                        viewModel.getLessons()
                    }
                    .padding(.horizontal, 24)
                }
            }
        }
    }
}


#Preview {
    RouterView { router in
        HomePage(viewModel: HomeViewModel(router: router))
    }
}
