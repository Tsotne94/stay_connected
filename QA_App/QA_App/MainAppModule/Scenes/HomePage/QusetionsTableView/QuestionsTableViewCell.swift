//
//  QuestionsTableViewCell.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 30.11.24.
//

import UIKit

class QuestionsTableViewCell: UITableViewCell, IdentifiableProtocol {
    private let subject = "Swift Operators"
    private let titleText = "How to implement the code"
    private let replayCount = "5"
    private let tags = ["IOS", "Backend", "Frontend"]
    
    private let subjectLabel = UILabel()
    private let replayCountLbel = UILabel()
    private let titleLabel = UILabel()
    private let tagLabels = [UILabel]()
    private let hasAcceptedAnswrMark = UIImageView()
    private let containerView = UIView()
    private let tagsView = TagsCollectionView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellUI() {
        contentView.backgroundColor = .background
        setupCpnteinerView()
        setupSubjectLabel()
        setupReplayCountLabel()
        setupTitleLabel()
        setupTagLabels()
        setupAcceptMark()
        setupConstraints()
    }
    
    private func setupCpnteinerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 15
        containerView.clipsToBounds = true
    }
    
    private func setupSubjectLabel() {
        subjectLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(subjectLabel)
        
        subjectLabel.text = subject
        subjectLabel.font = .systemFont(ofSize: 13, weight: .medium)
        subjectLabel.textColor = UIColor(named: AppAssets.Colors.replayColor)
        subjectLabel.backgroundColor = .clear
        subjectLabel.textAlignment = .left
        subjectLabel.numberOfLines = 1
    }
    
    private func setupReplayCountLabel() {
        replayCountLbel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(replayCountLbel)
        
        replayCountLbel.text = "replies: " + replayCount
        replayCountLbel.font = .systemFont(ofSize: 11, weight: .light)
        replayCountLbel.textColor = UIColor(named: AppAssets.Colors.replayColor)
        replayCountLbel.textAlignment = .right
        replayCountLbel.backgroundColor = .clear
        replayCountLbel.numberOfLines = 1
    }
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
        
        titleLabel.text = titleText
        titleLabel.font = .systemFont(ofSize: 15, weight: .regular)
        titleLabel.textColor = UIColor(named: AppAssets.Colors.bodyText)
        titleLabel.textAlignment = .left
        titleLabel.backgroundColor = .clear
    }
    
    private func setupTagLabels() {
        tagsView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(tagsView)
    }
    
    private func setupAcceptMark() {
        hasAcceptedAnswrMark.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(hasAcceptedAnswrMark)
        
        hasAcceptedAnswrMark.image = UIImage(named: AppAssets.Icons.checkMark)
        hasAcceptedAnswrMark.backgroundColor = .clear
        hasAcceptedAnswrMark.clipsToBounds = true
        hasAcceptedAnswrMark.contentMode = .scaleAspectFit
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            subjectLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            subjectLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            subjectLabel.heightAnchor.constraint(equalToConstant: 18),
            
            replayCountLbel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
            replayCountLbel.centerYAnchor.constraint(equalTo: subjectLabel.centerYAnchor),
            replayCountLbel.widthAnchor.constraint(lessThanOrEqualToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: subjectLabel.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 210),
            
            hasAcceptedAnswrMark.topAnchor.constraint(equalTo: replayCountLbel.bottomAnchor, constant: 15),
            hasAcceptedAnswrMark.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
            hasAcceptedAnswrMark.widthAnchor.constraint(equalToConstant: 26),
            hasAcceptedAnswrMark.heightAnchor.constraint(equalToConstant: 26),
            
            tagsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            tagsView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0),
            tagsView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -60),
            tagsView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5)
        ])
    }
}
