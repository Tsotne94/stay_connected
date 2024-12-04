//
//  QuestionModel.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 04.12.24.
//

import Foundation

struct Tag: Codable {
    let id: Int
    let name: String
}

struct Question: Codable {
    let id: Int
    let title: String
    let tags: [Tag]
    let answersCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case tags
        case answersCount = "answers_count"
    }
}

struct Response: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Question]
}
