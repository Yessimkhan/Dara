//
//  LessonModuleViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 16.04.2024.
//

import Foundation
import SwiftfulRouting
import Alamofire
import SwiftUI

final class LessonModuleViewModel: ObservableObject {
    let router: AnyRouter
    @Published var moduleArray: ModuleResponse = []
    @Published var isLoading: Bool = true
    @Published var selectedModule: String?
    let lessonId: Int
    let lessonName: String
    @AppStorage("userId") var userId: String?
    
    init(router: AnyRouter, lessonId: Int, lessonName: String) {
        self.router = router
        self.lessonId = lessonId
        self.lessonName = lessonName
        getModules()
    }
    
    func selectModule(_ moduleName: String) {
        withAnimation(.spring()) {
            if selectedModule == moduleName {
                selectedModule = nil
            } else {
                selectedModule = moduleName
            }
        }
    }
    
    func getModules() {
        isLoading = true
        HomeRepository().getModules(topicID: "\(lessonId)") { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.moduleArray = response
                    print("Modules get success")
                case .failure(let error):
                    print("Get Modules failed: \(error.localizedDescription)")
                }
            }
        }
    }
}
