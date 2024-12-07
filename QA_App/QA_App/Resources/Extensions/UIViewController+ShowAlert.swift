//
//  UIViewController+ShowAlert.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 04.12.24.
//
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

