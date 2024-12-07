//
//  LoginRequest.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 04.12.24.
//
import Foundation

struct LoginRequest: Codable {
    var email: String
    var password: String
}

struct LoginResponse: Codable {
    var refresh: String
    var access: String
}
