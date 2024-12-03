//
//  APIEndpoints.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 03.12.24.
//
enum APIEndpoints: String {
    case allTgs = "http://54.86.213.249/api/tags/"
    case signUp = "http://54.86.213.249/api/user/register/"
    case logIn = "http://54.86.213.249/api/user/login/"
    case qusetion = "http://54.86.213.249/api/questions/"
    case refresh = "http://54.86.213.249/api/user/login/refresh/"
    case profile = "http://54.86.213.249/api/user/profile/"
    case ownQuestions = "http://54.86.213.249/api/user/profile/owned_questions/"
}
