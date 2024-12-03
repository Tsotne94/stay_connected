//
//  ProfilePageViewControllerCell.swift
//  QA_App
//
//  Created by beqa on 01.12.24.
//

import UIKit

class ProfileCell: UITableViewCell {
    private let leftLabel = UILabel()
    private let rightLabel = UILabel()
    private let iconImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        leftLabel.font = .systemFont(ofSize: 16)
        leftLabel.textColor = .black

        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        rightLabel.font = .systemFont(ofSize: 16)
        rightLabel.textColor = .gray
        rightLabel.textAlignment = .right

        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit

        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)
        contentView.addSubview(iconImageView)

        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            

            leftLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 0),
            leftLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            rightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rightLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configureCell(leftText: String, rightText: String?, icon: UIImage?) {
        leftLabel.text = leftText
        rightLabel.text = rightText
        iconImageView.image = icon
        iconImageView.isHidden = (icon == nil)
    }
}
