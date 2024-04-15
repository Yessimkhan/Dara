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
    @Published var isLoading: Bool = false
    let lessonId: Int
    @AppStorage("user_id") var userId: String?
    
    init(router: AnyRouter, lessonId: Int) {
        self.router = router
        self.lessonId = lessonId
        getLessons()
    }
    
    
    func getLessons() {
        isLoading = true
        let headers: HTTPHeaders = [
            "Accept-Language": "en",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2MTZiM2I2NTFhNTE2ODY3MzIzNjU5MiIsImVtYWlsIjoiYXNldHpoYW5lZGlsb3Y2QGdtYWlsLmNvbSIsImxhbmd1YWdlIjoicnUiLCJpYXQiOjE3MTMxODYzMTEsImV4cCI6MTcxMzI0MDMxMX0.L2t-kl5WGWHY-ZmycxFeKaepCBaLgOl_Z4EhwmGkKSc"
        ]

        AF.request("http://localhost:5100/module/my/\(lessonId)", headers: headers).responseDecodable(of: ModuleResponse.self) { response in
            switch response.result {
            case .success(let data):
                self.isLoading = false
                self.moduleArray = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

import Foundation

// MARK: - ModuleResponseElement
struct ModuleResponseElement: Codable, Identifiable {
    let id, title: String
    let moduleResponseID: Int
    let translation: Translation?
    let score: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case moduleResponseID = "id"
        case translation, score
    }
}


typealias ModuleResponse = [ModuleResponseElement]
