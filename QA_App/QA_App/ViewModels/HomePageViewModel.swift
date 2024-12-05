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
    private var tagsArr = [Tag]()
    weak var delegate: ReloadTable?
    var questionsChange: (() -> Void)?
    
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
        return tagsArr
    }
    
    var questionQount: Int {
        response.count
    }
    
    func singleQuestion(at: Int) -> Question {
        response.results[at]
    }
    
    private func fetchQuestions() {
        let token = getToken()
        networkManager.fetchData(
            from: APIEndpoints.qusetion.rawValue,
            modelType: Response.self,
            bearerToken: token,
            completion: { [weak self] result in
                switch result {
                case .success(let questions):
                    self?.response = questions
                    DispatchQueue.main.async { [weak self] in
                        self?.delegate?.reload()
                    }
                case .failure(let error):
                    print("failde to fetch questions for home page" + "\(error.localizedDescription)")
                }
            })
    }
    
    private func fetchTags() {
        let token = getToken()
        print(token)
        networkManager.fetchData(
            from: APIEndpoints.allTags.rawValue,
            modelType: [Tag].self,
            bearerToken: token) { (result: Result<[Tag], Error>) in
                switch result {
                case .success(let fetchedTags):
                    self.tagsArr = fetchedTags
                case .failure(let error):
                    print("Error fetching tags: \(error)")
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
}
