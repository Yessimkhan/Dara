//
//  HomeRepository.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 14.04.2024.
//

import Foundation
import SwiftUI
import Alamofire
import SVGKit

final class HomeRepository {
    @AppStorage("accessToken") var accessToken: String?
    @AppStorage("acceptLanguage") var acceptLanguage: String?
    @AppStorage("userId") var userId: String?
    private lazy var headers: HTTPHeaders = [
        "Accept-Language": acceptLanguage ?? "",
        "Authorization": "Bearer \(accessToken ?? "")"
    ]
    
    func getTopics(levelID: String, completion: @escaping (Result<TopicsResponse, Error>) -> Void) {
        let parameters: [String: Any] = [
            "level_id": levelID,
        ]
        
        NetworkClient.shared.get(endpoint: "/topic/my/", parameters: parameters, headers: headers) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(TopicsResponse.self, from: data)
                    let sortedData = response.sorted(by: { $0.topicsResponseID < $1.topicsResponseID })
                    completion(.success(sortedData))
                } catch {
                    print("Failed to decode response: \(error)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Failed to make request: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    func getModules(topicID: String, completion: @escaping (Result<ModuleResponse, Error>) -> Void) {
        let parameters: [String: Any] = [
            "topic_id": topicID,
        ]
        
        NetworkClient.shared.get(endpoint: "/module/my", parameters: parameters, headers: headers) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(ModuleResponse.self, from: data)
                    let sortedData = response.sorted(by: { $0.moduleResponseID < $1.moduleResponseID })
                    completion(.success(sortedData))
                } catch {
                    print("Failed to decode response: \(error)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Failed to make request: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    func getPage(topicID: String, moduleID: String, pageID: String, completion: @escaping (Result<PageResponse, Error>) -> Void) {
        let parameters: [String: Any] = [
            "page_id": pageID,
            "module_id": moduleID,
            "topic_id": topicID,
        ]
        
        NetworkClient.shared.get(endpoint: "/page", parameters: parameters, headers: headers) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(PageResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    print("Failed to decode response: \(error)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Failed to make request: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    func downloadImage(from url: String, completion: @escaping (Image?) -> Void) {
        NetworkClient.shared.download(url, headers: headers) { response in
            switch response {
            case .success(let response):
                guard let mimeType = response.response.mimeType else {
                    print("Failed to get data or MIME type.")
                    return
                }
                switch mimeType {
                case "image/jpeg", "image/png":  // Handling both JPEG and PNG
                    completion(Image(uiImage: UIImage(data: response.data) ?? UIImage()))
                case "image/svg+xml":
                    let svgImage = SVGKImage(data: response.data)
                    if let uiImage = svgImage?.uiImage {
                        completion(Image(uiImage: uiImage))
                    } else {
                        print("Failed to convert SVG data to UIImage")
                        completion(nil)
                    }
                default:
                    print("Unsupported MIME uu type: \(mimeType)")
                    completion(nil)
                }
                
            case .failure(let error):
                print("Error downloading image: \(error)")
                completion(nil)
            }
        }
    }
    
    func downloadAudio(from url: String, completion: @escaping (Data?) -> Void) {
        NetworkClient.shared.download(url, headers: headers) { response in
            switch response {
            case .success(let result):
                DispatchQueue.main.async {
                    completion(result.data)
                }
            case .failure(let error):
                print("Error downloading audio: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func putScore(topicID: String, score: Int, completion: @escaping (Result<TestProgressResponse, Error>) -> Void) {
        let parameters: [String: Any] = [
            "user_id": userId ?? "",
            "topic_id": topicID,
            "score": score
        ]
        
        NetworkClient.shared.put(endpoint: "/module/test", parameters: parameters, headers: headers) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(TestProgressResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    print("Failed to decode response: \(error)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Failed to make request: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
//    func getAlphabet(completion: @escaping (Result<PageResponse, Error>) -> Void) {
//        let parameters: [String: Any] = [
//            "page_id": pageID,
//            "module_id": moduleID,
//            "topic_id": topicID,
//        ]
//        
//        NetworkClient.shared.get(endpoint: "/page", parameters: parameters, headers: headers) { result in
//            switch result {
//            case .success(let data):
//                do {
//                    let decoder = JSONDecoder()
//                    let response = try decoder.decode(PageResponse.self, from: data)
//                    completion(.success(response))
//                } catch {
//                    print("Failed to decode response: \(error)")
//                    completion(.failure(error))
//                }
//            case .failure(let error):
//                print("Failed to make request: \(error.localizedDescription)")
//                completion(.failure(error))
//            }
//        }
//    }
    
}
