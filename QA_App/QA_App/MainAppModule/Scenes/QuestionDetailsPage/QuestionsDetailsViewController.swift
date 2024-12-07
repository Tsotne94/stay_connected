//
//  QuestionsDetailsViewController.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 01.12.24.
//
//
import UIKit

protocol QuestionsTableViewDelegate: AnyObject {
    func didSelectQuestion(question: Question)
}

class QuestionsDetailsViewController: UIViewController {
    private let backButton = UIButton()
    private let subjectLabel = UILabel()
    private let titleLabel = UILabel()
    private let publisherLabel = UILabel()
    private let answersTablevIew = UITableView()
    private var answerTextField: UITextField?
    private let answerButotn = UIButton()
    private var question: Question?
    private var viewModel: QuestionDetailsViewModel?
    
    init(question: Question) {
        super.init(nibName: nil, bundle: nil)
        viewModel = QuestionDetailsViewModel(id: question.id)
        viewModel?.delegate = self
        self.question = question
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
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupSubjectLabel() {
        subjectLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subjectLabel)
        
        subjectLabel.font = .systemFont(ofSize: 13, weight: .regular)
        subjectLabel.textColor = UIColor(named: AppAssets.Colors.tabTitle)
        subjectLabel.textAlignment = .left
        subjectLabel.text = question?.title
    }
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        titleLabel.numberOfLines = 3
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor(named: AppAssets.Colors.bodyText)
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.text = question?.content
        titleLabel.numberOfLines = 0
    }
    
    private func setupPublisherLabel() {
        publisherLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(publisherLabel)
        
        publisherLabel.numberOfLines = 0
        publisherLabel.font = .systemFont(ofSize: 13, weight: .regular)
        publisherLabel.textColor = UIColor(named: AppAssets.Colors.tabTitle)
        publisherLabel.textAlignment = .left
        publisherLabel.text = question?.author.fullName
        
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
        
        if viewModel?.replayCount ?? 6 < 5 {
            setupTextFields()
            answersTablevIew.tableFooterView = answerTextField
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
                answersTablevIew.bottomAnchor.constraint(equalTo: answerTextField?.topAnchor ?? view.bottomAnchor, constant: -5),
            ])
        }
    }
    
    private func setupTextFields() {
        answerTextField = UITextField()
        guard let answerTextField else { return }
        answerTextField.sizeToFit()

        setupPadding(for: answerTextField)
        
        answerTextField.placeholder = "Type your reply here"
        answerTextField.layer.borderWidth = 1
        answerTextField.layer.borderColor = UIColor(named: AppAssets.Colors.tabTitle)?.cgColor
        answerTextField.layer.cornerRadius = 12
        
        if viewModel?.replayCount ?? 4 > 5 {
            answerTextField.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(answerTextField)
            
            NSLayoutConstraint.activate([
                answerTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                answerTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
                answerTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
                answerTextField.heightAnchor.constraint(equalToConstant: 45)
            ])
        } else {
            answerTextField.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 20, height: 45)
        }
        
        answerButotn.addTarget(self, action: #selector(answerTapped), for: .touchUpInside)
    }
    
    @objc private func answerTapped() {
        guard let answerTextField = answerTextField else {
            print("Answer text field is nil.")
            return
        }
        
        guard let answerText = answerTextField.text, !answerText.isEmpty, answerText.count > 15 else {
            showAlert(title: "Replay has to be longer that 15 caracters", message: "replay is too short")
            return
        }
        let answer: AnswerModelRequest = AnswerModelRequest(content: answerText)
        viewModel?.postAnswer(answer: answer)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.answersTablevIew.reloadData()
            self.view.layoutIfNeeded()
        })
        answerTextField.text = ""
    }
    
    private func setupPadding(for searchBar: UITextField) {
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 40))
        answerButotn.setImage(UIImage(named: AppAssets.Icons.sendMessage), for: .normal)
        answerButotn.tintColor = .gray
                    
        answerButotn.frame = CGRect(x: 0, y: (rightPaddingView.bounds.height - 25) / 2, width: 30, height: 25)
        answerButotn.clipsToBounds = true
        rightPaddingView.addSubview(answerButotn)
        rightPaddingView.isUserInteractionEnabled = true
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: searchBar.frame.height))
        
        searchBar.rightView = rightPaddingView
        searchBar.rightViewMode = .always
        
        searchBar.leftView = leftPaddingView
        searchBar.leftViewMode = .always
        
        answerButotn.addTarget(self, action: #selector(answerTapped), for: .touchUpInside)
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
        viewModel?.replayCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnswersTableViewCell.reuseIdentifier, for: indexPath) as! AnswersTableViewCell
        guard let answer = viewModel?.singleAnswer(at: indexPath.row) else { return cell }
        cell.configure(answer: answer)
        return cell
    }
}

extension QuestionsDetailsViewController: ReloadTable {
    func reloadTable() {
        DispatchQueue.main.async { [weak self] in
            self?.answersTablevIew.reloadData()
        }

    }
    
    func reload() {
        print("wrong reload")
    }
}
