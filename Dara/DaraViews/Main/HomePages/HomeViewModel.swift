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
    @Published var errorMessage: String = ""
    @Published var lessonsArray: TopicsResponse = []
    @Published var imagesArray: [Image] = []
    @Published var isLoading: Bool = false
    @AppStorage("user_id") var userId: String?
    @AppStorage("user_level") var userLevel: Int = 1
    private var downloadCount = 0
    
    init(router: AnyRouter) {
        self.router = router
        getLessons()
    }
    
    
    func getLessons() {
        isLoading = true
        HomeRepository().getTopics(levelID: userLevel) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.lessonsArray = response
                    self?.imagesArray = Array(repeating: Image(uiImage: UIImage()), count: response.count)
                    var downloadImages = self?.imagesArray
                    for (index, url) in response.enumerated() {
                        HomeRepository().downloadImage(from: url.image) { [weak self] image in
                            guard let self = self else { return }
                            DispatchQueue.main.async {
                                downloadImages?[index] = image ?? Image(systemName: "star.fill")
                                self.downloadCount += 1
                                if self.downloadCount == response.count {
                                    self.isLoading = false
                                    self.imagesArray = downloadImages ?? []
                                }
                            }
                        }
                    }
                    print("Lessons get success")
                case .failure(let error):
                    self?.errorMessage = "\(error)"
                    print("Get lessons failed: \(error)")
                }
            }
        }
    }
}


