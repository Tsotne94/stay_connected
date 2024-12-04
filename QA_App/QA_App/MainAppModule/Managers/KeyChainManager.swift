//
//  KeyChainManager.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 04.12.24.
//
import Foundation
import UIKit

enum KeyChainError: Error {
    case duplicateEntry
    case unknown(OSStatus)
    case invalidData
}

class KeyChainManager {
    static func save(
        service: String,
        account: String,
        token: Data
    ) throws {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: token as AnyObject,
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            throw KeyChainError.duplicateEntry
        }
        
        guard status == errSecSuccess else {
            throw KeyChainError.unknown(status)
        }
        print("saved")
    }
    
    static func get(
        service: String,
        account: String
    ) -> Data? {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        print(status)
        
        return result as? Data
    }
    
    static func deleteAllKeychainItems() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword
        ]
        
        SecItemDelete(query as CFDictionary)
        let allClasses: [CFString] = [kSecClassGenericPassword, kSecClassInternetPassword, kSecClassKey, kSecClassCertificate]
        
        for keyClass in allClasses {
            let deleteQuery: [String: Any] = [kSecClass as String: keyClass]
            SecItemDelete(deleteQuery as CFDictionary)
        }
        
        print("All Keychain items cleared.")
    }
}
