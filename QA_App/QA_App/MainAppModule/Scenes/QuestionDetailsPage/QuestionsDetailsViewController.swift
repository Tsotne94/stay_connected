//
//  QuestionsDetailsViewController.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 01.12.24.
//
//
import UIKit

class QuestionsDetailsViewController: UIViewController {
    private var answerNumber = 3
    private let backButton = UIButton()
    private let subjectLabel = UILabel()
    private let titleLabel = UILabel()
    private let publisherLabel = UILabel()
    private let answersTablevIew = UITableView()
    private var searchBar: UITextField?
    private let answerButotn = UIButton()
    
    init(question: String) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        navigationController?.isNavigationBarHidden = true
        setupBackButton()
        setupSubjectLabel()
        setupTitleLabel()
        setupPublisherLabel()
        setupAnswersTableView()
        setupConstraints()
    }

    private func setupBackButton() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        backButton.backgroundColor = .clear
        backButton.setTitle("", for: .normal)
        backButton.setImage(UIImage(named: AppAssets.Icons.back), for: .normal)
    }
    
    private func setupSubjectLabel() {
        subjectLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subjectLabel)
        
        subjectLabel.font = .systemFont(ofSize: 13, weight: .regular)
        subjectLabel.textColor = UIColor(named: AppAssets.Colors.tabTitle)
        subjectLabel.textAlignment = .left
        subjectLabel.text = "Swift Operators"
    }
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        titleLabel.numberOfLines = 3
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor(named: AppAssets.Colors.bodyText)
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.text = "VoiceOver is a central part of Apple's accessibility system, to the point not accessible to other accessibility systems in iOS?"
    }
    
    private func setupPublisherLabel() {
        publisherLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(publisherLabel)
        
        publisherLabel.numberOfLines = 0
        publisherLabel.font = .systemFont(ofSize: 13, weight: .regular)
        publisherLabel.textColor = UIColor(named: AppAssets.Colors.tabTitle)
        publisherLabel.textAlignment = .left
        publisherLabel.text = "@userNameHere asked on 11/24/2024 at 0:33"
        
    }
    
    private func setupAnswersTableView() {
        answersTablevIew.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(answersTablevIew)
        
        answersTablevIew.dataSource = self
        answersTablevIew.delegate = self
        answersTablevIew.register(AnswersTableViewCell.self, forCellReuseIdentifier: AnswersTableViewCell.reuseIdentifier)
        
        answersTablevIew.rowHeight = UITableView.automaticDimension
        answersTablevIew.estimatedRowHeight = 100
        answersTablevIew.backgroundColor = .white
        answersTablevIew.separatorStyle = .none
        
        if answerNumber < 5 {
            setupTextFields()
            answersTablevIew.tableFooterView = searchBar
            NSLayoutConstraint.activate([
                answersTablevIew.topAnchor.constraint(equalTo: publisherLabel.bottomAnchor, constant: 20),
                answersTablevIew.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
                answersTablevIew.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
                answersTablevIew.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
            
        } else {
            setupTextFields()
            NSLayoutConstraint.activate([
                answersTablevIew.topAnchor.constraint(equalTo: publisherLabel.bottomAnchor, constant: 20),
                answersTablevIew.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
                answersTablevIew.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
                answersTablevIew.bottomAnchor.constraint(equalTo: searchBar?.topAnchor ?? view.bottomAnchor, constant: -5),
            ])
        }
    }
    
    private func setupTextFields() {
        searchBar = UITextField()
        guard let searchBar else { return }
        searchBar.sizeToFit()

        setupPadding(for: searchBar)
        
        searchBar.placeholder = "Type your reply here"
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor(named: AppAssets.Colors.tabTitle)?.cgColor
        searchBar.layer.cornerRadius = 12
        
        if answerNumber > 5 {
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(searchBar)
            
            NSLayoutConstraint.activate([
                searchBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
                searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
                searchBar.heightAnchor.constraint(equalToConstant: 45)
            ])
        } else {
            searchBar.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 20, height: 45)
        }
    }

    private func setupPadding(for searchBar: UITextField) {
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: searchBar.frame.height))
        answerButotn.setImage(UIImage(named: AppAssets.Icons.sendMessage), for: .normal)
        answerButotn.tintColor = .gray
                    
        answerButotn.frame = CGRect(x: -10, y: 0, width: 25, height: 25)
        rightPaddingView.addSubview(answerButotn)
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: searchBar.frame.height))
        
        searchBar.rightView = rightPaddingView
        searchBar.rightViewMode = .always
        
        searchBar.leftView = leftPaddingView
        searchBar.leftViewMode = .always
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            
            subjectLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10),
            subjectLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            
            titleLabel.topAnchor.constraint(equalTo: subjectLabel.bottomAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
            publisherLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            publisherLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            publisherLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
        ])
    }
}

extension QuestionsDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answerNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnswersTableViewCell.reuseIdentifier, for: indexPath) as! AnswersTableViewCell
        return cell
    }
}


