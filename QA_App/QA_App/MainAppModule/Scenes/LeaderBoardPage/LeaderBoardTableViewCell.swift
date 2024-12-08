//
//  LeaderBoardTableViewCell.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 08.12.24.
//
import UIKit

class LeaderboardTableViewCell: UITableViewCell {
    let nameLabel = UILabel()
    let usernameLabel = UILabel()
    let scoreLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        contentView.addSubview(nameLabel)
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.font = UIFont.systemFont(ofSize: 14)
        usernameLabel.textColor = .gray
        contentView.addSubview(usernameLabel)
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.font = UIFont.systemFont(ofSize: 14)
        scoreLabel.textColor = .gray
        contentView.addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            usernameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            usernameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            usernameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            scoreLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            scoreLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
        ])
    }
    
    func configure(with model: UserRating) {
        nameLabel.text = model.fullName
        usernameLabel.text = "@\(model.fullName)"
        scoreLabel.text = "Score: \(model.score)"
    }
}
