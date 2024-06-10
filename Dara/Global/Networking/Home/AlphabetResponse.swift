//
//  AlphabetResponse.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 10.06.2024.
//

import Foundation

// MARK: - AlphabetResponseElement
struct AlphabetResponseElement: Codable {
    let id: String
    let alphabetResponseID: Int
    let title, audio: String
    let translation: Translation?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case alphabetResponseID = "id"
        case title, audio, translation
    }
}

typealias AlphabetResponse = [AlphabetResponseElement]
