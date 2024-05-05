//
//  ModulePagesViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 17.04.2024.
//

import Foundation
import SwiftfulRouting
import SwiftUI

final class ModulePagesViewModel: ObservableObject {
    let lessonId: Int
    let moduleId: Int
    let allPages: Int
    let allTasks: Int
    var currentPage: Int
    var currentTask: Int
    let router: AnyRouter
    let homeRepository = HomeRepository()
    @Published var isLoading: Bool = false
    @AppStorage("acceptLanguage") var acceptLanguage: String?
    
    init(router: AnyRouter, lessonId: Int, moduleId: Int, allPages: Int, allTasks: Int, currentPage: Int, currentTask: Int) {
        self.router = router
        self.lessonId = lessonId
        self.moduleId = moduleId
        self.allPages = allPages
        self.allTasks = allTasks
        self.currentPage = currentPage
        self.currentTask = currentTask
        print("was inited")
    }
    
    func getPages() {
        guard currentPage <= allPages else {
            print("Finish")
            router.dismissScreenStack()
            return
        }
        isLoading = true
        homeRepository.getPage(topicID: "\(lessonId)", moduleID: "\(moduleId)", pageID: "\(currentPage)") { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    print("Page get success")
                    self.handlePageData(pageResponse: response)
                case .failure(let error):
                    self.currentPage += 1
                    self.currentTask += 1
                    self.getPages()
                    print("Get page failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func handlePageData(pageResponse: PageResponse) {
        currentPage += 1
        currentTask += 1
        switch pageResponse.page.pageType {
        case "hint":
            print("Hint")
            currentTask -= 1
            handleHint(pageResponse.content)
        case "text":
            print("text")
            handleText(pageResponse.content)
        case "tf":
            print("tf")
            handleTrueFalse(pageResponse.content)
        case "variant":
            print("variant")
            handleVariant(pageResponse.content)
        case "matchword":
            print("matchword")
            handleMatching(pageResponse.content, title: "Сәйкестендіру")
        default:
            print(pageResponse.page.pageType)
            print("Unknown page type")
            getPages()
        }
    }
    
    func handleHint(_ contents: [Content]) {
        if contents.count != 0 {
            router.showScreen(.push) { router in
                HintPage(viewModel: HintViewModel(data: contents[0]), modulePagesViewModel: self)
                    .navigationBarTitle("\(contents[0].translation.title)", displayMode: .inline)
            }
        } else {
            getPages()
        }
    }
    
    func handleText(_ contents: [Content]) {
        if contents.count != 0 {
            router.showScreen(.push) { router in
                TextPage(viewModel: TextViewModel(data: contents[0]), modulePagesViewModel: self)
                    .navigationBarTitle("\(contents[0].translation.title)", displayMode: .inline)
            }
        } else {
            getPages()
        }
    }
    
    func handleTrueFalse(_ contents: [Content]) {
        if contents.count != 0 {
            router.showScreen(.push) { router in
                TrueFalsePage(viewModel: TrueFalseViewModel(data: contents[0]), modulePagesViewModel: self)
                    .navigationBarTitle("\(contents[0].translation.title)", displayMode: .inline)
            }
        } else {
            getPages()
        }
    }
    
    func handleVariant(_ contents: [Content]) {
        if contents.count != 0 {
            router.showScreen(.push) { router in
                VariantPage(viewModel: VariantViewModel(data: contents[0]), modulePagesViewModel: self)
                    .navigationBarTitle("\(contents[0].translation.title)", displayMode: .inline)
            }
        } else {
            getPages()
        }
    }
    
    func handleMatching(_ contents: [Content], title: String) {
        if contents.count != 0 {
            router.showScreen(.push) { router in
                Matching(viewModel: MathingViewModel(data: contents), modulePagesViewModel: self)
                    .navigationBarTitle("\(contents[0].translation.title)", displayMode: .inline)
            }
        }
    }
    
    func getLineWidth() -> CGFloat {
        var width = 342
        width = (width / allTasks) * (currentTask - 1)
        if width > 342 {
            width = 342
        }
        return CGFloat(width)
    }
}




