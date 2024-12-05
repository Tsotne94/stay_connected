//
//  TagsCollectionViewCell.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 30.11.24.
//
//

import UIKit

class TagsCollectionViewCell: UICollectionViewCell, IdentifiableProtocol {
    let tagButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: AppAssets.Colors.tagBackground)
        button.setTitleColor(UIColor(named: AppAssets.Colors.tagText), for: .normal)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        return button
    }()
    
    var pressed = false

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
        contentView.addSubview(tagButton)
        tagButton.isUserInteractionEnabled = false
        
        NSLayoutConstraint.activate([
            tagButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            tagButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            tagButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            tagButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tagButton.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    func configureCell(with tag: Tag) {
        tagButton.setTitle("   \(tag.name)   ", for: .normal)        
        layoutIfNeeded()
    }
    
    func cellPressed(with: Tag) {
        tagButton.setTitleColor(.white, for: .normal)
        tagButton.setTitle(with.name, for: .normal)
        tagButton.backgroundColor = UIColor(named: AppAssets.Colors.primaryButtonHighlighted)
        layoutIfNeeded()
    }
}

