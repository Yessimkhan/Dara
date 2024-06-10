//
//  ModuleResponse.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 24.04.2024.
//

import Foundation

// MARK: - ModuleResponseElement
struct ModuleResponseElement: Codable, Identifiable {
    let id, title: String
    let moduleResponseID: Int
    let translation: Translation?
    let isCompleted: Bool?
    let pageCount: Int?
    let taskCount: Int?
    let score: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case moduleResponseID = "id"
        case translation
        case isCompleted = "is_completed"
        case pageCount = "page_count"
        case taskCount = "task_count"
        case score
    }
}

typealias ModuleResponse = [ModuleResponseElement]
