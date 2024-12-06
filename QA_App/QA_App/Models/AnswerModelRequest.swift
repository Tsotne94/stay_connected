//
//  AnswerModel.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 07.12.24.
//

import Foundation

// Answer Model used in the request
struct AnswerModelRequest: Codable {
    var content: String
}

// The Detailed Question Model
struct DetailedQuestion: Codable {
    let id: Int
    let author: Author
    let title: String
    let content: String
    let tags: [Tag]
    let createdAt: String
    let updatedAt: String
    var acceptedAnswer: Int?  // Change from Answer to Int (to store ID)
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

// The Answer Model used for answers
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


