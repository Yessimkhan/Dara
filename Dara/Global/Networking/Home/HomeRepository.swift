//
//  HomeRepository.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 14.04.2024.
//

import Foundation
import SwiftUI
import Alamofire

final class HomeRepository {
    @AppStorage("accessToken") var accessToken: String?
    
//    func getTopics() -> TopicsResponse {
//        let headers: HTTPHeaders = [
//            "Accept-Language": "en",
//            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2MTZiM2I2NTFhNTE2ODY3MzIzNjU5MiIsImVtYWlsIjoiYXNldHpoYW5lZGlsb3Y2QGdtYWlsLmNvbSIsImxhbmd1YWdlIjoicnUiLCJpYXQiOjE3MTMxODYzMTEsImV4cCI6MTcxMzI0MDMxMX0.L2t-kl5WGWHY-ZmycxFeKaepCBaLgOl_Z4EhwmGkKSc"
//        ]
//
//        AF.request("http://localhost:5100/topic/my/1", headers: headers).responseDecodable(of: TopicsResponse.self) { response in
//            return response.result
//        }
//    }
}
