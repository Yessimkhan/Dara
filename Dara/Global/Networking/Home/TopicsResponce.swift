//
//  HomeResponce.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 14.04.2024.
//

import Foundation

// MARK: - TopicsResponseElement
struct TopicsResponseElement: Identifiable, Codable {
    let id: String
    let topicsResponseID, levelID: Int
    let title: String
    let isOpened: Bool

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case topicsResponseID = "id"
        case levelID = "level_id"
        case title, isOpened
    }
}

typealias TopicsResponse = [TopicsResponseElement]
