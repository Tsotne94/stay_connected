//
//  AddQuestionViewModel.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 07.12.24.
//
import Foundation
import UIKit
import MyNetworkManager

protocol AddQUestion: AnyObject {
    func reload()
    func success()
}

class AddQuestionViewModel {
    private var tagsArr = TagsResponse(count: 0, next: nil, previous: nil, results: [])
    weak var delegate: AddQUestion?
    
    let networkManager: NetworkPackage
    
    init(networkManager: NetworkPackage = NetworkPackage()) {
        self.networkManager = networkManager
        fetchTags()
    }
    
    func tags() -> [Tag] {
        return tagsArr.results
    }
    
    func addQuestion(question: AddQuestionModel) {
        let token = getToken()
        networkManager.postData(
            to: APIEndpoints.qusetion.rawValue,
            modelType: AddQuestionModel.self,
            requestBody: question,
            bearerToken: token) { [weak self] result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async { [weak self] in
                        self?.delegate?.success()
                    }
                case .failure(let failure):
                    DispatchQueue.main.async { [weak self] in
                        self?.delegate?.success()
                    }
                    print(failure.localizedDescription)
                }
            }
    }

    private func fetchTags() {
        let token = getToken()
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
}
