//
//  RegisterData.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 03.12.24.
//
struct RegisterRequest: Codable {
    var email: String
    var fullName: String
    var password: String
    var confirmPassword: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case fullName = "full_name"
        case password
        case confirmPassword = "confirm_password"
    }
}
