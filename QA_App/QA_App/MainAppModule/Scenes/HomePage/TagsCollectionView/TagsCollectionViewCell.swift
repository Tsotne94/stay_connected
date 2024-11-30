//
//  TagsCollectionViewCell.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 30.11.24.
//

import UIKit

class TagsCollectionViewCell: UICollectionViewCell, IdentifiableProtocol {
    let tagButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .clear
        setupTagButton()
    }
    
    private func setupTagButton() {
        tagButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tagButton)
    
        tagButton.backgroundColor = UIColor(named: AppAssets.Colors.tagBackground)
        tagButton.setTitleColor(UIColor(named: AppAssets.Colors.tagText), for: .normal)
        
        tagButton.layer.cornerRadius = 18
        tagButton.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            tagButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            tagButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            tagButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            tagButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configureCell(wiht tag: String) {
        tagButton.setTitle("   \(tag)   ", for: .normal)
    }
}
