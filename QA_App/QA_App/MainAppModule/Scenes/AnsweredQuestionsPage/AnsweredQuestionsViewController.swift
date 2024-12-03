//
//  AnsweredQuestionsViewController.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 02.12.24.
//

import UIKit

class AnsweredQuestionsViewController: UIViewController {
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    private let questionTableView = QuestionsTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        setupBackButton()
        setupTitleLabel()
        setupTableView()
        setupConstraints()
    }
    
    private func setupBackButton() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        backButton.backgroundColor = .clear
        backButton.setTitle("", for: .normal)
        backButton.setImage(UIImage(named: AppAssets.Icons.back), for: .normal)
        
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        titleLabel.font = UIFont(name: MyFonts.anekBold.rawValue, size: 20)
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor(named: AppAssets.Colors.bodyText)
        titleLabel.text = "Answered Questions"
    }
    
    private func setupTableView() {
        questionTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionTableView)
        
        questionTableView.backgroundColor = .clear
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            
            questionTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            questionTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            questionTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            questionTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}
