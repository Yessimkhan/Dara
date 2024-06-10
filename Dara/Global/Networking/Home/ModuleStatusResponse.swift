//
//  ModuleStatusResponse.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 10.06.2024.
//

import Foundation

// MARK: - ModuleStatusResponse
struct ModuleStatusResponse: Codable {
    let moduleProgress: ModuleProgress?
}

// MARK: - ModuleProgress
struct ModuleProgress: Codable {
    let id, userID: String
    let topicID, moduleID: Int
    let isCompleted: Bool
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case topicID = "topic_id"
        case moduleID = "module_id"
        case isCompleted = "is_completed"
        case v = "__v"
    }
}
