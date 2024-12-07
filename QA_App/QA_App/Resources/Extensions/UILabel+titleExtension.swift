//
//  UILabel+titleExtension.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 05.12.24.
//
import UIKit

extension UILabel {
    func configureTitleLabel(
        text: String,
        fontName: String? = nil,
        fontSize: CGFloat,
        textColor: UIColor? = nil,
        textAlignment: NSTextAlignment = .left
    ) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.font = fontName != nil ? UIFont(name: fontName!, size: fontSize) : UIFont.systemFont(ofSize: fontSize)
        self.textColor = textColor
        self.textAlignment = textAlignment
    }
}
