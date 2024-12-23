//
//  AnswersTableViewCell.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 01.12.24.
//

import UIKit
import MyDateFormatter

class AnswersTableViewCell: UITableViewCell, IdentifiableProtocol {
    let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let dateLabel = UILabel()
    private let answerLabel = UILabel()
    private let acceptedBadge = UIImageView()
    private let dateFormatter = MyDateFormatter()

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
        setupConstraints()
        setupAnswerLabel()
        setupAcceptedBagde()
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
    }
    
    private func setupDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        
        dateLabel.textColor = UIColor(named: AppAssets.Colors.bodyText)
        dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        dateLabel.textAlignment = .left
    }
    
    private func setupAnswerLabel() {
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(answerLabel)
        
        answerLabel.numberOfLines = 4
        answerLabel.lineBreakMode = .byTruncatingTail
        answerLabel.textColor = UIColor(named: AppAssets.Colors.bodyText)
        answerLabel.textAlignment = .left
        answerLabel.font = .systemFont(ofSize: 15, weight: .regular)
    }
    
    private func setupAcceptedBagde() {
        acceptedBadge.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(acceptedBadge)
        
        acceptedBadge.image = UIImage(named: AppAssets.Icons.badgeAccepted)
    
        acceptedBadge.backgroundColor = .clear
        acceptedBadge.clipsToBounds = true
        acceptedBadge.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            acceptedBadge.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            acceptedBadge.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5)
        ])
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
        ])
    }
    
    func configure(answer: Answer, isAccepted:  Bool) {
        if isAccepted {
            nameLabel.text = answer.author.fullName
            dateLabel.text = dateFormatter.format(answer.createdAt)
            answerLabel.text = answer.content
            acceptedBadge.isHidden = false
            layoutIfNeeded()
        } else {
            nameLabel.text = answer.author.fullName
            dateLabel.text = dateFormatter.format(answer.createdAt)
            answerLabel.text = answer.content
            acceptedBadge.isHidden = true
            layoutIfNeeded()
        }
        
        print(isAccepted)
    }
}
