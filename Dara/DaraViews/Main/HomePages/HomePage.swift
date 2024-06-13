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
                if viewModel.isError {
                    VStack (spacing: 32) {
                        VStack (spacing: 16) {
                            Images.eaglesImage
                            Text("Lessons are currently unavailable.")
                                .font(.system(size: 20, weight: .semibold))
                                .multilineTextAlignment(.center)
                            Text(viewModel.errorMessage)
                                .font(.system(size: 16, weight: .semibold))
                                .multilineTextAlignment(.center)
                        }
                        
                        Button {
                            viewModel.getLessons()
                        } label: {
                            ButtonView(buttonType: .retry)
                        }

                    }
                } else {
                    ScrollView (showsIndicators: false) {
                        VStack(spacing: 10) {
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
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(viewModel.isError ? .large : .automatic)
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


#Preview {
    RouterView { router in
        HomePage(viewModel: HomeViewModel(router: router))
    }
}
