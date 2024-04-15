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
        let headers: HTTPHeaders = [
            "Accept-Language": "en",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2MTZiM2I2NTFhNTE2ODY3MzIzNjU5MiIsImVtYWlsIjoiYXNldHpoYW5lZGlsb3Y2QGdtYWlsLmNvbSIsImxhbmd1YWdlIjoicnUiLCJpYXQiOjE3MTMxODYzMTEsImV4cCI6MTcxMzI0MDMxMX0.L2t-kl5WGWHY-ZmycxFeKaepCBaLgOl_Z4EhwmGkKSc"
        ]

        AF.request("http://localhost:5100/topic/my/1", headers: headers).responseDecodable(of: TopicsResponse.self) { response in
            switch response.result {
            case .success(let data):
                self.isLoading = false
                self.lessonsArray = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


