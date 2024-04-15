//
//  AuthRepository.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 07.04.2024.
//

import Foundation

final class AuthRepository {
    
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

}
