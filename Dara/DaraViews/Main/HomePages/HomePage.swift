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
            }
            ScrollView (showsIndicators: false) {
                VStack (spacing: 10){
                    ForEach(viewModel.lessonsArray) { lesson in
                        if lesson.topicsResponseID <= 10 {
                            LessonView(lessonDate: lesson)
                                .onTapGesture {
                                    viewModel.router.showScreen(.push) { router in
                                        LessonModulesPage(viewModel: LessonModuleViewModel(router: router, lessonId: lesson.topicsResponseID))
                                            .navigationBarTitle(lesson.title, displayMode: .inline)
                                            .toolbar(.hidden, for: .tabBar)
                                    }
                                }
                        }
                    }
                }
                .padding(.horizontal, 24)
            }
        }
    }
}


#Preview {
    RouterView { router in
        HomePage(viewModel: HomeViewModel(router: router))
    }
}
