//
//  TestProgressResponse.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 08.05.2024.
//

import Foundation

// MARK: - TestProgressResponse
struct TestProgressResponse: Codable {
    let testProgress: TestProgress
}

// MARK: - TestProgress
struct TestProgress: Codable {
    let id, userID: String
    let topicID: Int
    let score: Double
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case topicID = "topic_id"
        case score
        case v = "__v"
    }
}
