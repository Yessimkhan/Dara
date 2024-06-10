//
//  AuthRepository.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 07.04.2024.
//

import Foundation
import SwiftUI
import Alamofire

final class AuthRepository {
    
    @AppStorage("userLanguage") var userLanguage: String = NSLocale.current.language.languageCode?.identifier ?? "en"
    private lazy var headers: HTTPHeaders = [
        "Accept-Language": userLanguage,
    ]
    
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        NetworkClient.shared.post(endpoint: "/auth/login", parameters: parameters) { result in
            switch result {
            case .success(let data):
                print(data)
                print(parameters)
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(LoginResponse.self, from: data)
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
    
    func loginWithUsername(username: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        NetworkClient.shared.post(endpoint: "/auth/login-username", parameters: parameters) { result in
            switch result {
            case .success(let data):
                print(data)
                print(parameters)
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(LoginResponse.self, from: data)
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
    
    func register(level_id: Int, email: String, username: String, phone: String, password: String, language: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        let parameters: [String: Any] = [
            "level_id": level_id,
            "email": email,
            "username": username,
            "phone": phone,
            "password": password,
            "language": language
        ]
        
        NetworkClient.shared.post(endpoint: "/auth/registration", parameters: parameters) { result in
            switch result {
            case .success(let data):
                print(data)
                print(parameters)
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(LoginResponse.self, from: data)
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
    
    func forgotPassword(email: String, completion: @escaping (Result<MessageResponse, Error>) -> Void) {
        let parameters: [String: Any] = [
            "email": email,
        ]
        
        NetworkClient.shared.post(endpoint: "/auth/forgot-password", parameters: parameters, headers: headers) { result in
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
    
    func checkUsername(username: String, completion: @escaping (Result<UserNameResponse, Error>) -> Void) {
        let parameters: [String: Any] = [
            "username": username,
        ]
        
        NetworkClient.shared.post(endpoint: "/auth/check-username", parameters: parameters) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(UserNameResponse.self, from: data)
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
