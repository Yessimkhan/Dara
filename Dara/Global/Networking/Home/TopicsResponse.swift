//
//  HomeResponce.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 14.04.2024.
//

import Foundation

// MARK: - TopicsResponseElement
struct TopicsResponseElement: Codable, Identifiable {
    let id: String
    let topicsResponseID, levelID: Int
    let title: String
    let image: String
    let isOpened: Bool
    let translation: Translation

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case topicsResponseID = "id"
        case levelID = "level_id"
        case title, isOpened, translation, image
    }
}

// MARK: - Translation
struct Translation: Codable {
    let title: String
    let description, example, question: String?
}

typealias TopicsResponse = [TopicsResponseElement]
