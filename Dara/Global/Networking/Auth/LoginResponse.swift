//
//  LoginResponce.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 07.04.2024.
//

import Foundation

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let accessToken, refreshToken: String
    let user: User
}

// MARK: - User
struct User: Codable {
    let id: String
}
