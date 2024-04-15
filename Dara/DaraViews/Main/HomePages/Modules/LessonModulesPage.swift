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
    @State private var selectedModule: String?
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                LoaderView()
            } else {
                ForEach(viewModel.moduleArray) { module in
                    LessonModuleView(isSelected: .constant(selectedModule == module.title), moduleName: module.title, procent: module.score, router: viewModel.router)
                        .onTapGesture {
                            selectModule(module.title)
                        }
                }
            }
        }
        .padding(.horizontal, 24)
    }
    
    private func selectModule(_ moduleName: String) {
        withAnimation(.spring()) {
            if selectedModule == moduleName {
                selectedModule = nil
            } else {
                selectedModule = moduleName
                
            }
        }
    }
}

#Preview {
    RouterView{ router in
        LessonModulesPage(viewModel: LessonModuleViewModel(router: router, lessonId: 1))
    }
}
