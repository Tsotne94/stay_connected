//
//  LeaderBoardModel.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 08.12.24.
//

struct LeaderboardModel: Codable{
    let count: Int
    let next: String?
    let previous: String?
    let results: [UserRating]
}

struct UserRating: Codable {
    let fullName: String
    let score: Int
    let profilePicture: String?

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case score
        case profilePicture = "profile_picture"
    }
}
