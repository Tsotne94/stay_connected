//
//  QuestionsTableViewCell.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 30.11.24.
//

import UIKit

class QuestionsTableViewCell: UITableViewCell, IdentifiableProtocol {
    private let subjectLabel = UILabel()
    private let replayCountLabel = UILabel()
    private let titleLabel = UILabel()
    private let hasAcceptedAnswerMark = UIImageView()
    private let containerView = UIView()
    private var tagsView = TagsCollectionView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellUI() {
        contentView.backgroundColor = .background
        setupContainerView()
        setupSubjectLabel()
        setupReplayCountLabel()
        setupTitleLabel()
        setupAcceptedMark()
        setupCollectionView()
        setupConstraints()
    }
    
    private func setupContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 15
        containerView.clipsToBounds = true
    }
    
    private func setupSubjectLabel() {
        subjectLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(subjectLabel)
        
        subjectLabel.font = .systemFont(ofSize: 13, weight: .medium)
        subjectLabel.textColor = UIColor(named: AppAssets.Colors.replayColor)
        subjectLabel.backgroundColor = .clear
        subjectLabel.textAlignment = .left
        subjectLabel.numberOfLines = 1
    }
    
    private func setupReplayCountLabel() {
        replayCountLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(replayCountLabel)
        
        replayCountLabel.font = .systemFont(ofSize: 11, weight: .light)
        replayCountLabel.textColor = UIColor(named: AppAssets.Colors.replayColor)
        replayCountLabel.textAlignment = .right
        replayCountLabel.backgroundColor = .clear
        replayCountLabel.numberOfLines = 1
    }
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
        
        titleLabel.font = .systemFont(ofSize: 15, weight: .regular)
        titleLabel.textColor = UIColor(named: AppAssets.Colors.bodyText)
        titleLabel.textAlignment = .left
        titleLabel.backgroundColor = .clear
    }
    
    private func setupAcceptedMark() {
        hasAcceptedAnswerMark.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(hasAcceptedAnswerMark)
        
        hasAcceptedAnswerMark.image = UIImage(named: AppAssets.Icons.checkMark)
        hasAcceptedAnswerMark.backgroundColor = .clear
        hasAcceptedAnswerMark.clipsToBounds = true
        hasAcceptedAnswerMark.contentMode = .scaleAspectFit
    }
    
    private func setupCollectionView() {
        tagsView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(tagsView)
        
        tagsView.disableUserInteraction()
        
        NSLayoutConstraint.activate([
            tagsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            tagsView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            tagsView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
            tagsView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
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
            subjectLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -65),
            
            replayCountLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
            replayCountLabel.centerYAnchor.constraint(equalTo: subjectLabel.centerYAnchor),
            replayCountLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: subjectLabel.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -45),
            
            hasAcceptedAnswerMark.topAnchor.constraint(equalTo: replayCountLabel.bottomAnchor, constant: 15),
            hasAcceptedAnswerMark.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
            hasAcceptedAnswerMark.widthAnchor.constraint(equalToConstant: 26),
            hasAcceptedAnswerMark.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    func configure(with question: Question) {
        titleLabel.text = question.title
        replayCountLabel.text = "replies: \(question.answersCount)"
        subjectLabel.text = question.content
        
        if question.acceptedAnswer == nil {
            hasAcceptedAnswerMark.isHidden = true
        }
        
        tagsView.updateTags(question.tags)
    }
}
