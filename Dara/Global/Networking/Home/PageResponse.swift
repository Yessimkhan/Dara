//
//  PageResponse.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 24.04.2024.
//

import Foundation

struct PageResponse: Codable {
    let page: Page
    let content: [Content]
}

struct Page: Codable {
    let _id: String
    let id: Int
    let topicId: Int
    let moduleId: Int
    let pageType: String
    
    enum CodingKeys: String, CodingKey {
        case _id, id
        case topicId = "topic_id"
        case moduleId = "module_id"
        case pageType = "page_type"
    }
}

struct Content: Codable {
    let id: String
    let topicId: Int
    let moduleId: Int
    let pageId: Int
    let title: String
    let description: String?
    let logo: String?
    let content: [String]?
    let example: String?
    let image: String?
    let audio: String?
    let variants: [String]?
    let translation: Translation
    
    enum CodingKeys: String, CodingKey {
        case title, description, logo, example, image, audio, translation, content, variants
        case id = "_id"
        case topicId = "topic_id"
        case moduleId = "module_id"
        case pageId = "page_id"
    }
}
