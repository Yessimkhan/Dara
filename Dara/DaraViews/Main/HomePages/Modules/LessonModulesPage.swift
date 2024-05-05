//
//  LessonModulesPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 09.04.2024.
//

import SwiftUI
import SwiftfulRouting

struct LessonModulesPage: View {
    
    @StateObject var viewModel: LessonModuleViewModel
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                LoaderView()
            } else {
                VStack {
                    ForEach(viewModel.moduleArray) { module in
                        LessonModuleView(isSelected: .constant(viewModel.selectedModule == module.title), moduleName: module.title, procent: module.score, lessonId: viewModel.lessonId, moduleId: module.moduleResponseID, allPages: module.pageCount, allTasks: module.taskCount ?? 0, router: viewModel.router)
                            .onTapGesture {
                                viewModel.selectModule(module.title)
                            }
                    }
                }
                .blur(radius: viewModel.isLoading ? 3 : 0)
                .padding(.horizontal, 24)
            }
        }
    }
}

#Preview {
    RouterView{ router in
        LessonModulesPage(viewModel: LessonModuleViewModel(router: router, lessonId: 2))
    }
}
