//
//  HomePageViewModel.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 04.12.24.
//
import Foundation
import UIKit
import MyNetworkManager

class HomePageViewModel: QuestionProtocol {
    private var response = Response(count: 0, next: nil, previous: nil, results: [Question]())
    private var tagsArr = TagsResponse(count: 0, next: nil, previous: nil, results: [])
    weak var delegate: ReloadTable?
    
    let networkManager: NetworkPackage
    
    init(networkManager: NetworkPackage = NetworkPackage()) {
        self.networkManager = networkManager
        fetchQuestions()
        fetchTags()
    }
    
    func asnwerCount(for index: Int) -> Int {
        Int(response.results[index].answersCount)
    }
    
    func tags() -> [Tag] {
        return tagsArr.results
    }
    
    var questionQount: Int {
        response.results.count
    }
    
    func singleQuestion(at: Int) -> Question {
        print("\(at)/n/n/nn/n/n//n/n/n/nn/n/n/nn/n/n/")
        return response.results[at]
    }
    
    private func fetchTags() {
        let token = getToken()
        print(token)
        networkManager.fetchData(
            from: APIEndpoints.allTags.rawValue,
            modelType: TagsResponse.self,
            bearerToken: token) { [weak self] result in
                switch result {
                case .success(let fetchedTags):
                    self?.tagsArr = fetchedTags
                    DispatchQueue.main.async { [weak self] in
                        self?.delegate?.reload()
                    }
                case .failure(let error):
                    print("Error fetching tags: \(error)")
                    DispatchQueue.main.async { [weak self] in
                        self?.navigateToHomePage()
                    }
                }
            }
    }
    
    func fetchQuestions(tag: String? = nil, search: String? = nil) {
        var urlComponents = URLComponents(string: APIEndpoints.qusetion.rawValue)!
        var queryItems = [URLQueryItem]()
        
        if let tag = tag {
            queryItems.append(URLQueryItem(name: "tags__name", value: tag))
        }
        
        if let search = search {
            queryItems.append(URLQueryItem(name: "search", value: search))
        }
        
        urlComponents.queryItems = queryItems.isEmpty ? nil : queryItems
        
        networkManager.fetchData(
            from: urlComponents.url!.absoluteString,
            modelType: Response.self,
            completion: { [weak self] result in
                switch result {
                case .success(let questions):
                    self?.response = questions
                    DispatchQueue.main.async { [weak self] in
                        self?.delegate?.reloadTable()
                    }
                case .failure(let error):
                    print("Error fetching tags: \(error)")
                    DispatchQueue.main.async { [weak self] in
                        self?.navigateToHomePage()
                    }
                }
            })
    }
    
    func fetchPersonalQuestions(tag: String? = nil, search: String? = nil) {
        let token = getToken()
        
        var urlComponents = URLComponents(string: APIEndpoints.personal.rawValue)!
        var queryItems = [URLQueryItem]()
        
        if let tag = tag {
            queryItems.append(URLQueryItem(name: "tags__name", value: tag))
        }
        
        if let search = search {
            queryItems.append(URLQueryItem(name: "search", value: search))
        }
        
        urlComponents.queryItems = queryItems.isEmpty ? nil : queryItems
        
        networkManager.fetchData(
            from: urlComponents.url!.absoluteString,
            modelType: Response.self,
            bearerToken: token,
            completion: { [weak self] result in
                switch result {
                case .success(let questions):
                    self?.response = questions
                    DispatchQueue.main.async { [weak self] in
                        self?.delegate?.reloadTable()
                    }
                case .failure(_):
                    DispatchQueue.main.async { [weak self] in
                        self?.navigateToHomePage()
                    }
                }
            })
    }
    
    private func navigateToHomePage() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: LoginPageViewController())
    }
}
