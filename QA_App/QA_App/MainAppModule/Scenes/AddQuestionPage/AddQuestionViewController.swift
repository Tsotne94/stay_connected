//
//  AddQuestionViewController.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 02.12.24.
//

import UIKit

class AddQuestionViewController: UIViewController {
    private let titleLabel = UILabel()
    private let titleContainerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        setupTitleContainer()
        setupTitleLabel()
        
        
        
        setupConstraints()
    }
    
    private func setupTitleContainer() {
        titleContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleContainerView)
        
        titleContainerView.backgroundColor = UIColor(named: AppAssets.Colors.addBackground)
    }
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleContainerView.addSubview(titleLabel)
        
        titleLabel.text = "Add Question"
        titleLabel.textColor = UIColor(named: AppAssets.Colors.bodyText)
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textAlignment = .center
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            titleContainerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            titleContainerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            titleContainerView.heightAnchor.constraint(equalTo: titleContainerView.widthAnchor, multiplier: 0.196),
            
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: titleContainerView.centerXAnchor)
        ])
        
    }
}
