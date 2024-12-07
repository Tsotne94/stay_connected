//
//  QuestionProtocol.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 04.12.24.
//
protocol QuestionProtocol: AnyObject {
    var questionQount: Int { get }
    func singleQuestion(at: Int) -> Question
    func tags() -> [Tag]
    func asnwerCount(for index: Int) -> Int
    func fetchQuestions(tag: String?, search: String?)
    func fetchPersonalQuestions(tag: String?, search: String?)
}
