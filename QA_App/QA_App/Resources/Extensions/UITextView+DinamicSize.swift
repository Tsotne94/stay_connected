//
//  UITextView+DinamicSize.swift
//  QA_App
//
//  Created by beqa on 07.12.24.
//
import UIKit


extension UITextView {
    func adjustHeight() {
        let size = CGSize(width: self.frame.width, height: .infinity)
        let estimatedSize = self.sizeThatFits(size)
        if estimatedSize.height != self.frame.height {
            UIView.animate(withDuration: 0.2) {
                self.constraints.forEach { constraint in
                    if constraint.firstAttribute == .height {
                        constraint.constant = estimatedSize.height
                        self.superview?.layoutIfNeeded()
                    }
                }
            }
        }
    }
}

