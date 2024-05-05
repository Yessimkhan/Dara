//
//  HomeViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 14.04.2024.
//

import Foundation
import SwiftfulRouting
import Alamofire
import SwiftUI

final class HomeViewModel: ObservableObject {
    let router: AnyRouter
    @Published var lessonsArray: TopicsResponse = []
    @Published var isLoading: Bool = false
    @AppStorage("user_id") var userId: String?
    
    init(router: AnyRouter) {
        self.router = router
        getLessons()
    }
    
    
    func getLessons() {
        isLoading = true
        HomeRepository().getTopics(levelID: "1") { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.lessonsArray = response
                    print("Lessons get success")
                case .failure(let error):
                    print("Get lessons failed: \(error.localizedDescription)")
                }
            }
        }
    }
}


