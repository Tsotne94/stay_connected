//
//  UITextfield+Shake.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 04.12.24.
//
import UIKit

extension UITextField {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.duration = 0.5
        animation.values = [-10, 10, -8, 8, -5, 5, 0]
        self.layer.add(animation, forKey: "shake")
    }
}
