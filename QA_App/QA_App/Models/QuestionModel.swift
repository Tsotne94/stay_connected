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
    let author: String
    let title: String
    let content: String
    let acceptedAnswer: String?
    let createdAt: String
    let answersCount: Int
    let tags: [Tag]
    
    enum CodingKeys: String, CodingKey {
        case id, author, title, content
        case acceptedAnswer = "accepted_answer"
        case createdAt = "created_at"
        case answersCount = "answers_count"
        case tags
    }
}

struct Response: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Question]
}
