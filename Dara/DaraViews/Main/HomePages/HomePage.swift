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
        if viewModel.isLoading {
            ProgressView()
        } else {
            ScrollView (showsIndicators: false){
                VStack (spacing: 10){
                    ForEach(viewModel.lessonsArray) { lesson in
                        LessonView(lessonDate: lesson)
                            .onTapGesture {
                                viewModel.router.showScreen(.push) { router in
                                    LessonModulesPage(router: router)
                                        .navigationTitle(lesson.title)
                                        .toolbar(.hidden, for: .tabBar)
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
