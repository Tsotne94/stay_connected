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

    init(networkService: NetworkPackage = NetworkPackage()) {
        self.networkService = networkService
    }

    func fetchUserProfile() {
        let token = getToken()
        networkService.fetchData(
            from: APIEndpoints.profile.rawValue,
            modelType: UserProfile.self,
            bearerToken: token
        ) { [weak self] result in
            DispatchQueue.main.async { [weak self] in
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



    
    


