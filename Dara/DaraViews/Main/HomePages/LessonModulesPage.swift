//
//  LessonModulesPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 09.04.2024.
//

import SwiftUI
import SwiftfulRouting

struct LessonModulesPage: View {
    let router: AnyRouter
    @State private var selectedModule: String?
    
    var body: some View {
        VStack {
            LessonModuleView(isSelected: .constant(selectedModule == "Vocabulary"), moduleName: "Vocabulary", procent: nil, router: router)
                .onTapGesture {
                    selectModule("Vocabulary")
                }
            LessonModuleView(isSelected: .constant(selectedModule == "Grammar"), moduleName: "Grammar", procent: nil, router: router)
                .onTapGesture {
                    selectModule("Grammar")
                }
            LessonModuleView(isSelected: .constant(selectedModule == "Dialog"), moduleName: "Dialog", procent: nil, router: router)
                .onTapGesture {
                    selectModule("Dialog")
                }
            LessonModuleView(isSelected: .constant(selectedModule == "Test"), moduleName: "Test", procent: 100, router: router)
                .onTapGesture {
                    selectModule("Test")
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
        LessonModulesPage(router: router)
    }
}
