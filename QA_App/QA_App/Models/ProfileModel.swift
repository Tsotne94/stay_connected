//
//  ProfileModel.swift
//  QA_App
//
//  Created by beqa on 07.12.24.
//

struct UserProfile: Codable {
    let fullName: String?
    let email: String
    let score: Int
    let ownedQuestionsCount: Int
    let answeredQuestionsCount: Int
    let profilePicture: String?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case email
        case score
        case ownedQuestionsCount = "owned_questions_count"
        case answeredQuestionsCount = "answered_questions_count"
        case profilePicture = "profile_picture"
    }
}
