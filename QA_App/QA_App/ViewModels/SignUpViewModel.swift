//
//  SignUpViewModel.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 03.12.24.
//
import UIKit
import Foundation
import MyNetworkManager

class SignUpViewModel {
    private let networkManager = NetworkPackage()
    
    
    func signUp(user: RegisterRequest, completion: @escaping (Result<String, Error>) -> Void) {
        networkManager.postData(
            to: APIEndpoints.signUp.rawValue,
            modelType: RegisterResponse.self,
            requestBody: user,
            completion: { result in
                switch result {
                case .success(_):
                    completion(.success("Registration successful"))
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        )
    }
}
