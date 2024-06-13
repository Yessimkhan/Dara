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
import Network

final class HomeViewModel: ObservableObject {
    let router: AnyRouter
    let errorMessage: LocalizedStringResource = "It seems you are not connected to the network. \nPlease check your connection or try again later."
    @Published var lessonsArray: TopicsResponse = []
    @Published var imagesArray: [Image?] = []
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @AppStorage("userId") var userId: String?
    @AppStorage("userLevel") var userLevel: Int = 1
    @AppStorage("userLanguage") var userLanguage: String = NSLocale.current.language.languageCode?.identifier ?? "en"
    
    private var monitor: NWPathMonitor
    private var isConnected: Bool = false

    init(router: AnyRouter) {
        self.router = router
        self.monitor = NWPathMonitor()
        self.startNetworkMonitoring()
        getLessons()
    }
    
    deinit {
        monitor.cancel()
    }
    
    func getLessons() {
        isError = false
        isLoading = true
        
        HomeRepository().getTopics(levelID: userLevel) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isError = false
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
                    self.isError = true
                    print("Get lessons failed: \(error)")
                }
            }
        }
    }
    
    private func startNetworkMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            if path.status == .satisfied {
                print("connected yesso retry!!!")
                if !self.isConnected {
                    self.isConnected = true
                    print("Network connected")
                    self.getLessons()
                }
            } else {
                DispatchQueue.main.async {
                    self.isError = true
                    self.isConnected = false
                }
                print("Network disconnected")
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
}
