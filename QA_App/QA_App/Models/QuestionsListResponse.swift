//
//  QuestionsListResponse.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 08.12.24.
//

import Foundation

struct QuestionListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Question]
}
