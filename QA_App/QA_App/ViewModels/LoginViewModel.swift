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
    let networkManager: NetworkPackage

    init(networkManager: NetworkPackage = NetworkPackage()) {
        self.networkManager = networkManager
    }

    func logIn(user: LoginRequest, completion: @escaping (Result<String, Error>) -> Void) {
        fetchLoginData(user: user) { [weak self] result in
            switch result {
            case .success(let loginResponse):
                self?.handleTokens(response: loginResponse, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func fetchLoginData(user: LoginRequest, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        networkManager.postData(
            to: APIEndpoints.logIn.rawValue,
            modelType: LoginResponse.self,
            requestBody: user
        ) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }

    private func handleTokens(response: LoginResponse, completion: @escaping (Result<String, Error>) -> Void) {
        do {
            guard let accessToken = response.access.data(using: .utf8),
                  let refreshToken = response.refresh.data(using: .utf8) else {
                throw KeyChainError.invalidData
            }

            try saveTokensIfNeeded(accessToken: accessToken, refreshToken: refreshToken)
            completion(.success("Login successful"))
        } catch {
            print("Failed to save data in Keychain: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }

    private func saveTokensIfNeeded(accessToken: Data, refreshToken: Data) throws {
        let accessTokenKey = "com.tbcAcademy.stayConnected.accessToken"
        let refreshTokenKey = "com.tbcAcademy.stayConnected.refreshToken"
        let service = "stayConnected"

        let existingAccessToken = KeyChainManager.get(service: service, account: accessTokenKey)
        
        if existingAccessToken?.isEmpty == true {
            try KeyChainManager.save(service: service, account: accessTokenKey, token: accessToken)
            try KeyChainManager.save(service: service, account: refreshTokenKey, token: refreshToken)
            print("Tokens saved successfully.")
        } else {
            print("Tokens already exist.")
        }
    }
}
