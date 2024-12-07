//
//  APIEndpoints.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 03.12.24.
//
enum APIEndpoints: String {
    case allTags = "https://tumana777.pythonanywhere.com/api/tags/"
    case signUp = "https://tumana777.pythonanywhere.com/api/user/register/"
    case logIn = "https://tumana777.pythonanywhere.com/api/user/login/"
    case qusetion = "https://tumana777.pythonanywhere.com/api/questions/"
    case refresh = "https://tumana777.pythonanywhere.com/api/user/login/refresh/"
    case profile = "https://tumana777.pythonanywhere.com/api/user/profile/"
    case personal = "https://tumana777.pythonanywhere.com/api/user/profile/owned_questions/"
}
