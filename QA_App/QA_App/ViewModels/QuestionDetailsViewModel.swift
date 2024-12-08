//
//  QuestionDetailsViewModel.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 06.12.24.
//
import MyNetworkManager
import UIKit
import Foundation

class QuestionDetailsViewModel {
    private var detailedQuestion: DetailedQuestion?
    private var questionID: Int?
    weak var delegate: ReloadTable?
    
    let networkManager: NetworkPackage
    
    init(networkManager: NetworkPackage = NetworkPackage(), id: Int) {
        self.networkManager = networkManager
        questionID = id
        fetchAnswers(for: questionID!)
    }
    
    private func fetchAnswers(for id: Int) {
        let token = getToken()
        
        var urlComponents = URLComponents(string: APIEndpoints.qusetion.rawValue)!
        urlComponents.path += "\(id)/"
        
        guard urlComponents.url != nil else {
            print("wrong URL fetch answers path")
            return
        }
        
        networkManager.fetchData(
            from: urlComponents.url!.absoluteString,
            modelType: DetailedQuestion.self,
            bearerToken: token) { [weak self] result in
                switch result {
                case .success(let answersArr):
                    self?.detailedQuestion = answersArr
                    DispatchQueue.main.async { [weak self] in
                        self?.delegate?.reloadTable()
                    }
                case .failure(let error):
                    print("faliure \(error.localizedDescription)")
                }
            }
    }
    
    func postAnswer(answer: AnswerModelRequest) {
        let token = getToken()
        
        var urlComponents = URLComponents(string: APIEndpoints.qusetion.rawValue)!
        guard let id = questionID else { return  }
        urlComponents.path += "\(id)/"
        urlComponents.path += "add_answer/"
        
        guard urlComponents.url != nil else {
            print("wrong URL fetch answers path")
            return
        }
        
        networkManager.postData(
            to: urlComponents.url!.absoluteString,
            modelType: AnswerModelRequest.self,
            requestBody: answer,
            bearerToken: token) { [weak self] result in
                switch result {
                case .success(_):
                    self?.fetchAnswers(for: self!.questionID!)
                case .failure(let failure):
                    print("failed to post answer \(failure.localizedDescription)")
                    DispatchQueue.main.async { [weak self] in
                        self?.delegate?.reload()
                    }
                }
            }
    }
    
    func acceptAnswer(at id: Int, accept: AcceptRequest) {
        let token = getToken()
        
        
        var urlComponents = URLComponents(string: APIEndpoints.qusetion.rawValue)!
        guard let id = questionID else { return  }
        urlComponents.path += "\(id)/"
        urlComponents.path += "accept_or_reject_answer/"
        
        guard urlComponents.url != nil else {
            print("wrong URL fetch answers path")
            return
        }
        
        networkManager.postData(
            to: urlComponents.url!.absoluteString,
            modelType: AcceptRequest.self,
            requestBody: accept,
            bearerToken: token) { [weak self] result in
                switch result {
                case .success(_):
                    self?.fetchAnswers(for: self!.questionID!)
                    DispatchQueue.main.async { [weak self] in
                        self?.delegate?.reload()
                    }
                case .failure(let failure):
                    print("failed \(failure.localizedDescription)")
                }
            }
    }
    
    func rejectAnswer(at id: Int, accept: RejectRequest) {
        let token = getToken()
        
        
        var urlComponents = URLComponents(string: APIEndpoints.qusetion.rawValue)!
        guard let id = questionID else { return  }
        urlComponents.path += "\(id)/"
        urlComponents.path += "accept_or_reject_answer/"
        
        guard urlComponents.url != nil else {
            print("wrong URL fetch answers path")
            return
        }
        
        networkManager.postData(
            to: urlComponents.url!.absoluteString,
            modelType: RejectRequest.self,
            requestBody: accept,
            bearerToken: token) { [weak self] result in
                switch result {
                case .success(_):
                    self?.fetchAnswers(for: self!.questionID!)
                    DispatchQueue.main.async { [weak self] in
                        self?.delegate?.reload()
                    }
                case .failure(let failure):
                    print("failed \(failure.localizedDescription)")
                }
            }
    }
    
    var replayCount: Int {
        return detailedQuestion?.answers.count ?? 0
    }
    
    func singleAnswer(at index: Int) -> Answer? {
        detailedQuestion?.answers[index]
    }
    
    func acceptedAnswer() -> Int? {
        detailedQuestion?.acceptedAnswer
    }
}
