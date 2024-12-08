//
//  AcceptRequest.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 08.12.24.
//
import Foundation

struct AcceptRequest: Codable {
    var answer_id: Int?

    enum CodingKeys: String, CodingKey {
        case answer_id = "answer_id"
    }
}

struct RejectRequest: Codable {
    var answer_id: String?

    enum CodingKeys: String, CodingKey {
        case answer_id = "answer_id"
    }
}
