//
//  IdentifiableProtocol.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 29.11.24.
//
protocol IdentifiableProtocol {
    static var reuseIdentifier: String { get }
}

extension IdentifiableProtocol {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
