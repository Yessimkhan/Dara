//
//  HintViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 18.04.2024.
//

import Foundation
import SwiftUI
import SwiftfulRouting

final class HintViewModel: ObservableObject {
    
    let router: AnyRouter
    let data: Content
    @Published var imagesArray: [Image] = []
    @Published var isLoading: Bool = false
    @AppStorage("userId") var userId: String?
    private var downloadCount = 0
    
    init(router: AnyRouter, data: Content) {
        self.router = router
        self.data = data
        guard let content = data.content else { return }
        isLoading = true
        self.imagesArray = Array(repeating: Image(uiImage: UIImage()), count: content.count)
        var downloadImages = self.imagesArray
        for (index, url) in content.enumerated() {
            HomeRepository().downloadImage(from: url) { [weak self] image in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    downloadImages[index] = image ?? Image(systemName: "star.fill")
                    self.downloadCount += 1
                    if self.downloadCount == content.count {
                        self.isLoading = false
                        self.imagesArray = downloadImages
                    }
                }
            }
        }
    }
}

