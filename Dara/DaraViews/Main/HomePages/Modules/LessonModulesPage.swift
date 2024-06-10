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
            VStack {
                ForEach(viewModel.moduleArray) { module in
                    LessonModuleView(isSelected: .constant(viewModel.selectedModule == module.title), isLoading: $viewModel.isLoading, lessonName: viewModel.lessonName, moduleName: module.translation?.title ?? "", procent: module.score, lessonId: viewModel.lessonId, moduleId: module.moduleResponseID, allPages: module.pageCount ?? 0, allTasks: module.taskCount ?? 0, router: viewModel.router, isCompleted: module.isCompleted)
                        .onTapGesture {
                            viewModel.selectModule(module.title)
                        }
                }
            }
            .disabled(viewModel.isLoading)
            .blur(radius: viewModel.isLoading ? 4 : 0)
            .padding(.horizontal, 24)
            if viewModel.isLoading {
                LoaderView()
            }
        }
        .toolbar {
            ToolbarItem (placement: .topBarLeading) {
                Button {
                    viewModel.router.dismissScreenStack()
                } label: {
                    Image(systemName: "chevron.left")
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    RouterView{ router in
        LessonModulesPage(viewModel: LessonModuleViewModel(router: router, lessonId: 2, lessonName: "Yesso"))
    }
}
