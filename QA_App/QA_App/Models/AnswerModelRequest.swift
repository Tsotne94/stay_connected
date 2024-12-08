//
//  AnswerModel.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 07.12.24.
//

import Foundation

struct AnswerModelRequest: Codable {
    var content: String
}

struct DetailedQuestion: Codable {
    let id: Int
    let author: Author
    let title: String
    let content: String
    let tags: [Tag]
    let createdAt: String
    let updatedAt: String
    var acceptedAnswer: Int?
    var answers: [Answer]
    
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case title
        case content
        case tags
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case acceptedAnswer = "accepted_answer"
        case answers
    }
}

struct Answer: Codable {
    let id: Int
    let author: Author
    let content: String
    let createdAt: String
    let updatedAt: String
    let likesCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case content
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case likesCount = "likes_count"
    }
}


