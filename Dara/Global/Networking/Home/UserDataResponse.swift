//
//  UserDataResponse.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 10.06.2024.
//

import Foundation

// MARK: - UserDataResponse
struct ProfileResponse: Codable {
    let id: String
    let levelID: Int
    let email, username, phone, password: String
    let createdAt, updatedAt: String
    let v: Int
    let language: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case levelID = "level_id"
        case email, username, phone, password, createdAt, updatedAt
        case v = "__v"
        case language
    }
}

struct UserNameResponse: Codable {
    let isExists: Bool
    
    enum CodingKeys: String, CodingKey {
        case isExists = "is_exists"
    }
}
