//
//  AddQuestionModel.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 07.12.24.
//
import Foundation

struct AddQuestionModel: Codable {
    var title: String
    var content: String
    var tags: [Int]
}

