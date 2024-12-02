//
//  AnswersTableViewCell.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 01.12.24.
//

import UIKit

class AnswersTableViewCell: UITableViewCell, IdentifiableProtocol {
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let dateLabel = UILabel()
    let answerLabel = UILabel()
    private let moreButton = UIButton()
    private let acceptedBadge = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    private func setupUI() {
        setupProfileImage()
        setupNameLabel()
        setupDateLabel()
        setupAnswerLabel()
        setupMoreButton()
        setupAcceptedBagde()
        setupConstraints()
    }
    
    private func setupProfileImage() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(profileImageView)
        
        profileImageView.image = UIImage(systemName: "person.fill")
        profileImageView.clipsToBounds = true
        profileImageView.backgroundColor = .gray
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 17
    }
    
    private func setupNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        nameLabel.textColor = UIColor(named: AppAssets.Colors.bodyText)
        nameLabel.font = .systemFont(ofSize: 15, weight: .bold)
        nameLabel.textAlignment = .left
        nameLabel.text = "User Useradze"
    }
    
    private func setupDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        
        dateLabel.textColor = UIColor(named: AppAssets.Colors.bodyText)
        dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        dateLabel.textAlignment = .left
        dateLabel.text = "Monday, 9 May 2024"
    }
    
    private func setupAnswerLabel() {
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(answerLabel)
        
        answerLabel.numberOfLines = 4
        answerLabel.lineBreakMode = .byTruncatingTail
        answerLabel.textColor = UIColor(named: AppAssets.Colors.bodyText)
        answerLabel.textAlignment = .left
        answerLabel.font = .systemFont(ofSize: 15, weight: .regular)
        answerLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."        
    }
    
    
    private func setupMoreButton() {
        
    }
    
    private func setupAcceptedBagde() {
        acceptedBadge.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(acceptedBadge)
        
        acceptedBadge.clipsToBounds = true
        acceptedBadge.contentMode = .scaleAspectFit
        acceptedBadge.image = UIImage(named: AppAssets.Icons.badgeAccepted)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profileImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            profileImageView.widthAnchor.constraint(equalToConstant: 34),
            profileImageView.heightAnchor.constraint(equalToConstant: 34),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 5),
            
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
            dateLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 5),
            
            answerLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            answerLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            answerLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            answerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            acceptedBadge.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            acceptedBadge.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5)
            
        ])
        
    }
}
