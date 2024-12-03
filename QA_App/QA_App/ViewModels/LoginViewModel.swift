//
//  LoginViewModel.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 04.12.24.
//
import Foundation
import UIKit
import MyNetworkManager

class LoginViewModel {
    private let networkManager = NetworkPackage()
    
    func logIn(user: LoginRequest, completion: @escaping (Result<String, Error>) -> Void) {
        networkManager.postData(
            to: APIEndpoints.logIn.rawValue,
            modelType: LoginResponse.self,
            requestBody: user,
            completion: { result in
                switch result {
                case .success(let data):
                    do {
                        guard let accessToken = data.access.data(using: .utf8) else {
                            throw KeyChainError.invalidData
                        }
                        
                        guard let refreshToken = data.refresh.data(using: .utf8) else {
                            throw KeyChainError.invalidData
                        }
                        
                        let exists = KeyChainManager.get(service: "stayConnected", account: "com.tbcAcademy.stayConnected.accessToken")
                        if exists?.isEmpty == true {
                            try KeyChainManager.save(
                                service: "stayConnected",
                                account: "com.tbcAcademy.stayConnected.accessToken",
                                token: accessToken
                            )
                            
                            try KeyChainManager.save(
                                service: "stayConnected",
                                account: "com.tbcAcademy.stayConnected.refreshToken",
                                token: refreshToken
                            )
                        }
                        
                        print("token already existed")
                        completion(.success("Login successful"))
                        
                    } catch {
                        print("Failed to save data in Keychain: \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                    
                    completion(.success("Registration successful"))
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        )
    }
}
