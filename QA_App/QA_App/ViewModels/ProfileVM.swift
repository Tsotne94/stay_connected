//
//  ProfileVM.swift
//  QA_App
//
//  Created by beqa on 07.12.24.
//

import Foundation
import MyNetworkManager

import Foundation

class ProfileViewModel {
    private let networkService: NetworkPackage

    var userProfile: UserProfile? {
        didSet {
            onUpdate?()
        }
    }

    var onUpdate: (() -> Void)?

    init(networkService: NetworkPackage) {
        self.networkService = networkService
    }

    func fetchUserProfile() {
        let token = getToken()
        networkService.fetchData(
            from: APIEndpoints.profile.rawValue,
            modelType: UserProfile.self,
            bearerToken: token
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    self?.userProfile = profile
                case .failure(let error):
                    print("failde to fetch questions for home page" + "\(error.localizedDescription)")
                }
            }
        }
    }
}
    
    private func getToken() -> String {
        let accessTokenKey = "com.tbcAcademy.stayConnected.accessToken"
        let service = "stayConnected"
        
        let result = KeyChainManager.get(service: service, account: accessTokenKey) ?? Data()
        return decodeToken(data: result)
    }
    
    private func decodeToken(data: Data) -> String {
        if let token = String(data: data, encoding: .utf8) {
            return token
        } else {
            return ""
        }
    }
    

