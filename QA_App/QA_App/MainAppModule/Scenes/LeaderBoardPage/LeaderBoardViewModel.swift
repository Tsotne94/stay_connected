//
//  LeaderBoardViewModel.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 08.12.24.
//
import MyNetworkManager
import UIKit
import Foundation

class LeaderBoardViewModel {
    private var leaders: LeaderboardModel?
    weak var delegate: LeaderReload?
    let networkManager: NetworkPackage
    
    init(networkManager: NetworkPackage = NetworkPackage()) {
        self.networkManager = networkManager
        fetchUsers()
    }
    
    private func fetchUsers() {
        networkManager.fetchData(
            from: APIEndpoints.leaderboard.rawValue,
            modelType: LeaderboardModel.self) { [weak self] result in
                switch result {
                case .success(let leaders):
                    self?.leaders = leaders
                    DispatchQueue.main.async { [weak self] in
                        self?.delegate?.reload()
                    }
                case .failure(let failure):
                    DispatchQueue.main.async { [weak self] in
                        self?.navigateToHomePage()
                    }
                }
            }
    
}
    
    
    private func navigateToHomePage() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: LoginPageViewController())
    }
    
   
    
    func singleUser(at index: Int) -> UserRating {
        leaders?.results[index] ?? UserRating(fullName: " ", score: 0, profilePicture: nil)
    }
    
    var usersCount: Int {
        leaders?.results.count ?? 0
    }
}
