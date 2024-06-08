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
    var score: Int = 0
    let router: AnyRouter
    let homeRepository = HomeRepository()
    @Published var isLoading: Bool = false
    @AppStorage("userLanguage") var userLanguage: String?
    
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
            let scoreInPercent: Int = score == 0 ? 0 : Int((Double(score) / Double(allTasks)) * 100)
            if moduleId == 4 {
                homeRepository.putScore(topicID: "\(lessonId)", score: scoreInPercent) { result in
                    print(result)
                }
            }
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
            handleHint(pageResponse.content, title: "Назар аударыңыз")
        case "text":
            print("text")
            handleText(pageResponse.content, title: "Текст")
        case "text+hint":
            print("text+hint")
            handleTextAndHint(pageResponse.content, title: "Текст және ереже")
        case "tf":
            print("tf")
            handleTrueFalse(pageResponse.content, title: "Тест")
        case "variant":
            print("variant")
            handleVariant(pageResponse.content, title: "Тест")
        case "matchword":
            print("matchword")
            handleMatching(pageResponse.content, title: "Сәйкестендіру")
        case "matchimage":
            print("matchimage")
            handleMatchimage(pageResponse.content, title: "Сәйкестендіру")
        case "dialog":
            print("dialog")
            handleDialog(pageResponse.content, title: "Диалог")
        case "card":
            print("card")
            handleCard(pageResponse.content, title: "Карта")
        case "shuffleword":
            print("shuffleword")
            handleShuffleword(pageResponse.content, title: "Аралас сөз")
        case "shuffledialog":
            print("shuffledialog")
            handleShuffldialog(pageResponse.content, title: "Aралас диалог")
        default:
            print(pageResponse.page.pageType)
            print("Unknown page type")
            getPages()
        }
    }
    
    func handleHint(_ contents: [Content], title: String) {
        if contents.count != 0 {
            router.showScreen(.push) { router in
                HintPage(viewModel: HintViewModel(router: router, data: contents[0]), modulePagesViewModel: self)
                    .navigationBarTitle(title, displayMode: .inline)
                    .navigationBarBackButtonHidden()
            }
        } else {
            getPages()
        }
    }
    
    func handleText(_ contents: [Content], title: String) {
        if contents.count != 0 {
            router.showScreen(.push) { router in
                TextPage(viewModel: TextViewModel(router: router, data: contents[0]), modulePagesViewModel: self)
                    .navigationBarTitle(title, displayMode: .inline)
                    .navigationBarBackButtonHidden()
            }
        } else {
            getPages()
        }
    }
    
    func handleTextAndHint(_ contents: [Content], title: String) {
        if contents.count != 0 {
            router.showScreen(.push) { router in
                TextAndHintPage(viewModel: TextAndHintViewModel(router: router, data: contents), modulePagesViewModel: self)
                    .navigationBarTitle(title, displayMode: .inline)
                    .navigationBarBackButtonHidden()
            }
        } else {
            getPages()
        }
    }
    
    func handleTrueFalse(_ contents: [Content], title: String) {
        if contents.count != 0 {
            router.showScreen(.push) { router in
                TrueFalsePage(viewModel: TrueFalseViewModel(router: router, data: contents[0]), modulePagesViewModel: self)
                    .navigationBarTitle(title, displayMode: .inline)
                    .navigationBarBackButtonHidden()
            }
        } else {
            getPages()
        }
    }
    
    func handleVariant(_ contents: [Content], title: String) {
        if contents.count != 0 {
            router.showScreen(.push) { router in
                VariantPage(viewModel: VariantViewModel(router: router, data: contents[0]), modulePagesViewModel: self)
                    .navigationBarTitle(title, displayMode: .inline)
                    .navigationBarBackButtonHidden()
            }
        } else {
            getPages()
        }
    }
    
    func handleMatching(_ contents: [Content], title: String) {
        if contents.count != 0 {
            router.showScreen(.push) { router in
                Matching(viewModel: MatchingViewModel(router: router, data: contents), modulePagesViewModel: self)
                    .navigationBarTitle(title, displayMode: .inline)
                    .navigationBarBackButtonHidden()
            }
        }
    }
    
    func handleMatchimage(_ contents: [Content], title: String) {
        if contents.count != 0 {
            router.showScreen(.push) { router in
                MatchimagePage(viewModel: MatchimageViewModel(router: router, data: contents), modulePagesViewModel: self)
                    .navigationBarTitle(title, displayMode: .inline)
                    .navigationBarBackButtonHidden()
            }
        }
    }
    
    func handleDialog(_ contents: [Content], title: String) {
        if contents.count != 0 {
            router.showScreen(.push) { router in
                DialogPage(viewModel: DialogViewModel(router: router, data: contents), modulePagesViewModel: self)
                    .navigationBarTitle(title, displayMode: .inline)
                    .navigationBarBackButtonHidden()
            }
        }
    }
    
    func handleCard(_ contents: [Content], title: String) {
        if contents.count != 0 {
            router.showScreen(.push) { router in
                CardPage(viewModel: CardViewModel(router: router, data: contents[0]), modulePagesViewModel: self)
                    .navigationBarTitle(title, displayMode: .inline)
                    .navigationBarBackButtonHidden()
            }
        } else {
            getPages()
        }
    }
    
    func handleShuffleword(_ contents: [Content], title: String) {
        if contents.count != 0 {
            router.showScreen(.push) { router in
                ShufflewordPage(viewModel: ShufflewordViewModel(router: router, data: contents[0]), modulePagesViewModel: self)
                    .navigationBarTitle(title, displayMode: .inline)
                    .navigationBarBackButtonHidden()
            }
        } else {
            getPages()
        }
    }
    
    func handleShuffldialog(_ contents: [Content], title: String) {
        if contents.count != 0 {
            router.showScreen(.push) { router in
                ShuffledialogPage(viewModel: ShuffledialogViewModel(router: router, data: contents[0]), modulePagesViewModel: self)
                    .navigationBarTitle(title, displayMode: .inline)
                    .navigationBarBackButtonHidden()
            }
        } else {
            getPages()
        }
    }
    
    func getLineWidth() -> CGFloat {
        var width = 342.0
        width = (width / Double(allTasks)) * Double((currentTask - 1))
        if width > 342.0 {
            width = 342.0
        }
        return CGFloat(width)
    }
    
//    func goBack () {
//        router.dismissScreenStack()
//        router.showScreen(.push) { router in
//            LessonModulesPage(viewModel: LessonModuleViewModel(router: router, lessonId: lesson.topicsResponseID))
//                .navigationBarTitle(modulePagesViewModel.lesson.title, displayMode: .inline)
//                .toolbar(.hidden, for: .tabBar)
//        }
//    }
}




