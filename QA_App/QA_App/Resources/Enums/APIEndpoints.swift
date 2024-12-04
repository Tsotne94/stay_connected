//
//  APIEndpoints.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 03.12.24.
//
enum APIEndpoints: String {
    case allTags = "http://52.203.162.247:8001/api/tags/"
    case signUp = "http://52.203.162.247:8001/api/user/register/"
    case logIn = "http://52.203.162.247:8001/api/user/login/"
    case qusetion = "http://52.203.162.247:8001/api/questions/"
    case refresh = "http://52.203.162.247:8001/api/user/login/refresh/"
    case profile = "http://52.203.162.247:8001/api/user/profile/"
    case ownQuestions = "http://52.203.162.247:8001/api/user/profile/owned_questions/"
}
