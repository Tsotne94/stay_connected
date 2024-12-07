//
//  HomePageViewController.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 29.11.24.
//

import UIKit

class HomePageViewController: UIViewController, IdentifiableProtocol {
    private var  general = true {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("generalChanged"), object: general)
        }
    }
    private let titleLabel = UILabel()
    private let addQuestionButton = UIButton()
    private let generalButton = UIButton()
    private let personalButton = UIButton()
    private let viewModel = HomePageViewModel()
    private var questionsTableView: QuestionsTableView?
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        questionsTableView = QuestionsTableView(viewModel: viewModel)
        questionsTableView?.delegate = self
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
        
        addQuestionButton.addTarget(self, action: #selector(addQuestionButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addQuestionButtonTapped() {
        let vc = AddQuestionViewController()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    private func setupGeneralButton() {
        let color = UIColor(named: AppAssets.Colors.primaryButtonHighlighted) ?? UIColor()
        configureButton(generalButton, title: "General", color: color)
        
        generalButton.addTarget(self, action: #selector(generalPressed), for: .touchUpInside)
    }
    
    @objc private func generalPressed() {
        if general != true {
            generalButton.backgroundColor = UIColor(named: AppAssets.Colors.primaryButtonHighlighted) ?? UIColor()
            personalButton.backgroundColor = UIColor(named: AppAssets.Colors.primaryButton) ?? UIColor()
            general = true
            viewModel.fetchQuestions()
        }
    }
    
    private func setupPersonalButton() {
        let color = UIColor(named: AppAssets.Colors.primaryButton) ?? UIColor()
        configureButton(personalButton, title: "Personal", color: color)
        
        personalButton.addTarget(self, action: #selector(personalPressed), for: .touchUpInside)
    }
    
    @objc private func personalPressed() {
        if general == true {
            personalButton.backgroundColor = UIColor(named: AppAssets.Colors.primaryButtonHighlighted) ?? UIColor()
            generalButton.backgroundColor = UIColor(named: AppAssets.Colors.primaryButton) ?? UIColor()
            general = false
            viewModel.fetchPersonalQuestions()
        }
    }
    
    
    private func setupQuestionsTableView() {
        questionsTableView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionsTableView ?? UIView())
        
        questionsTableView?.backgroundColor = .clear
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
            
            questionsTableView!.topAnchor.constraint(equalTo: personalButton.bottomAnchor, constant: 20),
            questionsTableView!.leftAnchor.constraint(equalTo: view.leftAnchor),
            questionsTableView!.rightAnchor.constraint(equalTo: view.rightAnchor),
            questionsTableView!.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomePageViewController: QuestionsTableViewDelegate {
    func didSelectQuestion(question: Question) {
        let vc = QuestionsDetailsViewController(question: question)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomePageViewController: UpdateQuestions {
    func update() {
        viewModel.fetchQuestions()
    }
}
