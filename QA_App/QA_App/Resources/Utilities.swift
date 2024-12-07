//
//  Utilities.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 07.12.24.
//
import Foundation

let accessTokenKey = "com.tbcAcademy.stayConnected.accessToken"
let refreshTokenKey = "com.tbcAcademy.stayConnected.refreshToken"
let service = "stayConnected"

func getToken() -> String {
    let accessTokenKey = "com.tbcAcademy.stayConnected.accessToken"
    let service = "stayConnected"
    
    let result = KeyChainManager.get(service: service, account: accessTokenKey) ?? Data()
    return decodeToken(data: result)
}

func decodeToken(data: Data) -> String {
    if let token = String(data: data, encoding: .utf8) {
        return token
    } else {
        return ""
    }
}
