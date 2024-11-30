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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellUI() {
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
        containerView.layer.cornerRadius = 22
        containerView.clipsToBounds = true
    }
    
    private func setupSubjectLabel() {
        subjectLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(subjectLabel)
        
        subjectLabel.text = subject
        subjectLabel.font = .systemFont(ofSize: 13, weight: .medium)
        subjectLabel.textColor = UIColor(named: AppAssets.Colors.questionSubjectText)
        subjectLabel.backgroundColor = .clear
        subjectLabel.textAlignment = .left
    }
    
    private func setupReplayCountLabel() {
        replayCountLbel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(replayCountLbel)
        
        replayCountLbel.text = "replies: " + replayCount
        replayCountLbel.font = .systemFont(ofSize: 11, weight: .light)
        replayCountLbel.textColor = UIColor(named: AppAssets.Colors.replayColor)
        replayCountLbel.textAlignment = .right
        replayCountLbel.backgroundColor = .clear
    }
    
    private func setupTitleLabel() {
        
    }
    
    private func setupTagLabels() {
        
    }
    
    private func setupAcceptMark() {
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            containerView.heightAnchor.constraint(equalToConstant: 100),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            subjectLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            subjectLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            
            replayCountLbel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
            replayCountLbel.centerYAnchor.constraint(equalTo: subjectLabel.centerYAnchor),
        ])
    }
}
