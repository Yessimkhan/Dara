//
//  LessonModuleView.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 08.04.2024.
//

import SwiftUI
import SwiftfulRouting

struct LessonModuleView: View {
    @Binding var isSelected: Bool
    let moduleName: String
    let procent: Int?
    let lessonId: Int
    let moduleId: Int
    let allPages: Int
    let allTasks: Int
    let router: AnyRouter
    
    var body: some View {
        Group {
            if isSelected {
                SelectedModel(moduleName: moduleName, procent: procent, lessonId: lessonId, moduleId: moduleId, allPages: allPages, allTasks: allTasks, router: router)
            } else {
                NotSelectedModel(moduleName: moduleName, procent: procent)
            }
        }
    }
}

struct SelectedModel: View {
    
    let moduleName: String
    let procent: Int?
    let lessonId: Int
    let moduleId: Int
    let allPages: Int
    let allTasks: Int
    let router: AnyRouter
    
    var body: some View {
        ZStack (alignment: .leading){
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Colors.brandPrimary)
                .frame(maxWidth: .infinity)
                .frame(height: 165)
            HStack(spacing: 30) {
                VStack {
                    
                    Text(moduleName)
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Colors.white)
                        .frame(width: 200, alignment: .leading)
                        .padding(.leading, 24)
                    if let procent = procent {
                        Text("\(procent)%")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(Colors.white)
                            .frame(width: 200, alignment: .leading)
                            .padding(.leading, 24)
                    }
                }
                
                Image(systemName: "arrow.forward.square")
                    .resizable()
                    .foregroundColor(Colors.white)
                    .frame(width: 48, height: 48)
                    .onTapGesture {
                        ModulePagesViewModel(router: router, lessonId: lessonId, moduleId: moduleId, allPages: allPages, allTasks: allTasks, currentPage: 1, currentTask: 1).getPages()
                    }
            }
        }
    }
}

struct NotSelectedModel: View {
    let moduleName: String
    let procent: Int?
    var body: some View {
        ZStack (alignment: .leading){
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.ultraThinMaterial)
                .frame(maxWidth: .infinity)
                .frame(height: 128)
            HStack(spacing: 0) {
                
                Text(moduleName)
                    .font(.system(size: 24))
                    .foregroundColor(Colors.brandPrimary)
                    .frame(width: 150, alignment: .leading)
                    .padding(.leading, 34)
                if let procent = procent {
                    Text("\(procent)%")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(Colors.brandPrimary)
                        .frame(width: 100, alignment: .leading)
                        .padding(.leading, 24)
                }
                
            }
        }
    }
}



//#Preview {
//    LessonModuleView(moduleName: "Vocabulary", procent: 55, router: )
//}
