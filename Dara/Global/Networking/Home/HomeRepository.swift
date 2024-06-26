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
    @AppStorage("userLanguage") var userLanguage: String = NSLocale.current.language.languageCode?.identifier ?? "en"
    @AppStorage("userId") var userId: String?
    private lazy var headers: HTTPHeaders = [
        "Accept-Language": userLanguage,
        "Authorization": "Bearer \(accessToken ?? "")"
    ]
    
    func getTopics(levelID: Int, completion: @escaping (Result<TopicsResponse, Error>) -> Void) {
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
                    var response = try decoder.decode(ModuleResponse.self, from: data)
                    response = response.sorted(by: { $0.moduleResponseID < $1.moduleResponseID })
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
    
    func putScore(topicID: Int, score: Int, completion: @escaping (Result<TestProgressResponse, Error>) -> Void) {
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
    
    func putModuleStatus(topicID: Int, moduleId: Int, isCompleted: Bool, completion: @escaping (Result<ModuleStatusResponse, Error>) -> Void) {
        let parameters: [String: Any] = [
            "user_id": userId ?? "",
            "topic_id": topicID,
            "module_id": moduleId,
            "is_completed": isCompleted
        ]
        
        NetworkClient.shared.put(endpoint: "/module/status", parameters: parameters, headers: headers) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(ModuleStatusResponse.self, from: data)
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
    
    func getAlphabet(completion: @escaping (Result<AlphabetResponse, Error>) -> Void) {
        NetworkClient.shared.get(endpoint: "/letter") { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(AlphabetResponse.self, from: data)
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
    
    func getProfile(completion: @escaping (Result<ProfileResponse, Error>) -> Void) {
        NetworkClient.shared.get(endpoint: "/user/my", headers: headers) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(ProfileResponse.self, from: data)
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
    
    func updateProfile(levelId: Int, email: String, username: String, phone: String, language: String, completion: @escaping (Result<ProfileResponse, Error>) -> Void) {
        
        let parameters: [String: Any] = [
            "level_id": levelId,
            "email": email,
            "username": username,
            "phone": phone,
            "language": language
          ]
        
        NetworkClient.shared.put(endpoint: "/user/my",parameters: parameters, headers: headers) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(ProfileResponse.self, from: data)
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
    
    func updatePassword(oldPassword: String, newPassword: String, completion: @escaping (Result<MessageResponse, Error>) -> Void) {
        let parameters: [String: Any] = [
            "current_password": oldPassword,
            "new_password": newPassword
        ]
        
        NetworkClient.shared.post(endpoint: "/user/password", parameters: parameters, headers: headers) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(MessageResponse.self, from: data)
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
    
    func deleteAccount(completion: @escaping (Result<MessageResponse, Error>) -> Void) {
        NetworkClient.shared.delete(endpoint: "/user/delete", headers: headers) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(MessageResponse.self, from: data)
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
}
