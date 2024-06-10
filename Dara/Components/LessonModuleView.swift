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
    @Binding var isLoading: Bool
    let lessonName: String
    let moduleName: String
    let procent: Int?
    let lessonId: Int
    let moduleId: Int
    let allPages: Int
    let allTasks: Int
    let router: AnyRouter
    let isCompleted: Bool?
    
    var body: some View {
        Group {
            if isSelected {
                SelectedModel(isLoading: $isLoading, lessonName: lessonName ,moduleName: moduleName, procent: procent, lessonId: lessonId, moduleId: moduleId, allPages: allPages, allTasks: allTasks, router: router)
            } else {
                NotSelectedModel(moduleName: moduleName, procent: procent, isCompleted: isCompleted)
            }
        }
    }
}

struct SelectedModel: View {
    @Binding var isLoading: Bool
    let lessonName: String
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
                        if !isLoading {
                            isLoading = true
                            DispatchQueue.main.async {
                                ModulePagesViewModel(router: router, lessonId: lessonId, moduleId: moduleId, allPages: allPages, allTasks: allTasks, currentPage: 1, currentTask: 1, lessonName: lessonName, isTapped: $isLoading).getPages()
                            }
                        }
                    }
            }
        }
    }
}

struct NotSelectedModel: View {
    let moduleName: String
    let procent: Int?
    let isCompleted: Bool?
    var body: some View {
        ZStack (alignment: .leading) {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Material.ultraThin)
                .fill(getIsCompleted() ? Colors.brandPrimary : Color.clear)
                .frame(maxWidth: .infinity)
                .frame(height: 128)
            HStack(spacing: 0) {
                VStack {
                    if getIsCompleted() {
                        Text("Completed")
                            .font(.system(size: 14))
                            .foregroundColor(Colors.white)
                            .frame(width: 150, alignment: .leading)
                            .padding(.leading, 34)
                    }
                    Text(moduleName)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(getIsCompleted() ? Colors.white : Colors.brandPrimary)
                        .frame(width: 150, alignment: .leading)
                        .padding(.leading, 34)
                }
                if let procent = procent {
                    Text("\(procent)%")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(getIsCompleted() ? Colors.white : Colors.brandPrimary)
                        .frame(width: 100, alignment: .leading)
                        .padding(.leading, 24)
                }
                
            }
        }
    }
    
    func getIsCompleted() -> Bool {
        if isCompleted == true {
            true
        } else if procent ?? 0 >= 100 {
            true
        } else {
            false
        }
    }
}



//#Preview {
//    LessonModuleView(moduleName: "Vocabulary", procent: 55, router: )
//}
