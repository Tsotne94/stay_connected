//
//  HomePageViewController.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 29.11.24.
//

import UIKit

class HomePageViewController: UIViewController, IdentifiableProtocol {
    private var general = true
    private let titleLabel = UILabel()
    private let addQuestionButton = UIButton()
    private let generalButton = UIButton()
    private let personalButton = UIButton()
    private let questionsTableView = QuestionsTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        title = "Home"
        setupTitleLabel()
        setupAddQusetionButton()
        setupGeneralButton()
        setupPersonalButton()
        setupQuestionsTableView()
        setupConstraints()
    }
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        titleLabel.text = "Qusetions"
        titleLabel.font = UIFont(name: MyFonts.anekBold.rawValue, size: 20)
        titleLabel.textAlignment = .left
    }
    
    private func setupAddQusetionButton() {
        addQuestionButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addQuestionButton)
        
        addQuestionButton.backgroundColor = .clear
        addQuestionButton.setTitle("", for: .normal)
        addQuestionButton.setImage(UIImage(named: AppAssets.Icons.add), for: .normal)
    }
    
    private func setupGeneralButton() {
        let color = UIColor(named: AppAssets.Colors.primaryButtonHighlighted) ?? UIColor()
        configureButton(generalButton, title: "General", color: color)
    }
    
    private func setupPersonalButton() {
        let color = UIColor(named: AppAssets.Colors.primaryButton) ?? UIColor()
        configureButton(personalButton, title: "Personal", color: color)
    }
    
    private func setupQuestionsTableView() {
        questionsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionsTableView)
        
        questionsTableView.backgroundColor = .clear
    }
    
    private func configureButton(_ button: UIButton, title: String, color: UIColor) {
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 600))
        button.backgroundColor = color
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            addQuestionButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            addQuestionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -35),
            
            generalButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            generalButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            generalButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45),
            generalButton.heightAnchor.constraint(equalTo: generalButton.widthAnchor, multiplier: 0.22),
            
            personalButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            personalButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            personalButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45),
            personalButton.heightAnchor.constraint(equalTo: personalButton.widthAnchor, multiplier: 0.22),
            
            questionsTableView.topAnchor.constraint(equalTo: personalButton.bottomAnchor, constant: 20),
            questionsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            questionsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            questionsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
}
