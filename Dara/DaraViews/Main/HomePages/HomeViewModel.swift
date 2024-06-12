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
    @Published var errorMessage: LocalizedStringResource? = nil
    @Published var lessonsArray: TopicsResponse = []
    @Published var imagesArray: [Image?] = []
    @Published var isLoading: Bool = false
    @AppStorage("userId") var userId: String?
    @AppStorage("userLevel") var userLevel: Int = 1
    @AppStorage("userLanguage") var userLanguage: String = NSLocale.current.language.languageCode?.identifier ?? "en"

    init(router: AnyRouter) {
        self.router = router
        getLessons()
    }
    
    func getLessons() {
        isLoading = true
        errorMessage = nil
        lessonsArray = []
        imagesArray = []
        
        HomeRepository().getTopics(levelID: userLevel) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.lessonsArray = response
                    self.imagesArray = Array(repeating: nil, count: response.count)
                    
                    // Create a Dispatch Group
                    let dispatchGroup = DispatchGroup()
                    
                    for (index, url) in response.enumerated() {
                        dispatchGroup.enter()
                        HomeRepository().downloadImage(from: url.image) { [weak self] image in
                            guard let self = self else {
                                dispatchGroup.leave()
                                return
                            }
                            DispatchQueue.main.async {
                                if index < self.imagesArray.count {
                                    self.imagesArray[index] = image ?? Image(systemName: "star.fill")
                                    print("\(index) image got \(String(describing: image))")
                                } else {
                                    print("Index \(index) is out of range for imagesArray")
                                }
                                dispatchGroup.leave()
                            }
                        }
                    }
                    
                    // Notify when all downloads are completed
                    dispatchGroup.notify(queue: .main) {
                        self.isLoading = false
                    }
                    
                    print("Lessons get success")
                case .failure(let error):
                    self.errorMessage = "Failed to load lessons. Please try again later."
                    print("Get lessons failed: \(error)")
                }
            }
        }
    }
}


