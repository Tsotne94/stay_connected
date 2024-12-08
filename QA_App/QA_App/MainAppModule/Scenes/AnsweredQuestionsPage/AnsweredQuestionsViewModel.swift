//
//  AnsweredQuestionsViewModel.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 08.12.24.
//
import UIKit
import Foundation
import MyNetworkManager

class AnsweredQuestionsViewModel: QuestionProtocol {
    private var response = QuestionListResponse(count: 0, next: nil, previous: nil, results: [])
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
        return response.results[at]
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
            modelType: QuestionListResponse.self,
            completion: { [weak self] result in
                switch result {
                case .success(let questions):
                    self?.response = questions
                    DispatchQueue.main.async { [weak self] in
                        self?.delegate?.reloadTable()
                    }
                case .failure(_):
                    print("failed to fetch data in \(self)")
                }
            })
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
                }
            }
    }
    
    func fetchPersonalQuestions(tag: String? = nil, search: String? = nil) {
        fatalError("youn dont have to call this function from \(self)")
    }
}

