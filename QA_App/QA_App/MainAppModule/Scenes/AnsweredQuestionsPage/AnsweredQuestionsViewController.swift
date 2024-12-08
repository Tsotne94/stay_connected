//
//  AnsweredQuestionsViewController.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 02.12.24.
//

import UIKit

protocol AnsweredDelegate: AnyObject {
    func didSelectQuestion(question: Question)
}

class AnsweredQuestionsViewController: UIViewController {
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    private var questionTableView: AnsweredQuestionsTable?
    
    init(viewModel: QuestionProtocol) {
        super.init(nibName: nil, bundle: nil)
        questionTableView = AnsweredQuestionsTable(viewModel: viewModel)
        questionTableView?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        questionTableView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionTableView!)
        
        questionTableView?.backgroundColor = .clear
    }
    
    private func setupConstraints() {
        guard let table = questionTableView else { return }
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            
            table.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            table.leftAnchor.constraint(equalTo: view.leftAnchor),
            table.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

extension AnsweredQuestionsViewController: AnsweredDelegate {
    func didSelectQuestion(question: Question) {
        let vc = QuestionsDetailsViewController(question: question)
        navigationController?.pushViewController(vc, animated: true)
    }
}
