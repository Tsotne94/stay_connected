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
    private let answersTableView = UITableView()
    private var answerTextField = UITextField()
    private let answerButton = UIButton()
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
        setupAnswerTextField()
        setupConstraints()
    }

    private func setupBackButton() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        backButton.backgroundColor = .clear
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
        answersTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(answersTableView)
        
        answersTableView.dataSource = self
        answersTableView.delegate = self
        answersTableView.register(AnswersTableViewCell.self, forCellReuseIdentifier: AnswersTableViewCell.reuseIdentifier)
        answersTableView.rowHeight = UITableView.automaticDimension
        answersTableView.estimatedRowHeight = 100
        answersTableView.backgroundColor = .white
        answersTableView.separatorStyle = .none
    }
    
    private func setupAnswerTextField() {
        answerTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(answerTextField)
        
        answerTextField.placeholder = "Type your reply here"
        answerTextField.layer.borderWidth = 1
        answerTextField.layer.borderColor = UIColor(named: AppAssets.Colors.tabTitle)?.cgColor
        answerTextField.layer.cornerRadius = 12
        answerTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true

        setupPadding(for: answerTextField)
    }
    
    @objc private func answerTapped() {
        guard let answerText = answerTextField.text, !answerText.isEmpty, answerText.count > 15 else {
            showAlert(title: "Replay has to be longer that 15 characters", message: "Replay is too short")
            return
        }
        
        let answer = AnswerModelRequest(content: answerText)
        viewModel?.postAnswer(answer: answer)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.answersTableView.reloadData()
            self.view.layoutIfNeeded()
        }
        answerTextField.text = ""
    }
    
    private func setupPadding(for textField: UITextField) {
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 40))
        
        answerButton.setImage(UIImage(named: AppAssets.Icons.sendMessage), for: .normal)
        answerButton.tintColor = .gray
        answerButton.frame = CGRect(x: 0, y: (rightPaddingView.bounds.height - 25) / 2, width: 30, height: 25)
        rightPaddingView.addSubview(answerButton)
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        
        textField.rightView = rightPaddingView
        textField.rightViewMode = .always
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        
        answerButton.addTarget(self, action: #selector(answerTapped), for: .touchUpInside)
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
            
            answerTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            answerTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            answerTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            answersTableView.topAnchor.constraint(equalTo: publisherLabel.bottomAnchor, constant: 20),
            answersTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            answersTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            answersTableView.bottomAnchor.constraint(equalTo: answerTextField.topAnchor, constant: -10),
        ])
    }
}

extension QuestionsDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.replayCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnswersTableViewCell.reuseIdentifier, for: indexPath) as! AnswersTableViewCell
        if indexPath.row == 0, let answer = viewModel?.acceptedAnswer() {
               setImage(for: cell.profileImageView, with: answer.author.imageUrl)
               cell.setupAccepted(answer: answer)
               return cell
           }

           let singleAnswerIndex = indexPath.row - (viewModel?.acceptedAnswer() != nil ? 1 : 0)
           guard let answer = viewModel?.singleAnswer(at: singleAnswerIndex) else {
               return cell
           }

           setImage(for: cell.profileImageView, with: answer.author.imageUrl)
           cell.configure(answer: answer)
           return cell
       }

       private func setImage(for imageView: UIImageView, with imageUrl: String?) {
           if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
               imageView.load(url: url)
           } else {
               imageView.image = UIImage(systemName: "person.fill")
           }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension QuestionsDetailsViewController: ReloadTable {
    func reload() {
        showAlert(title: "You can not replay to your own Questions", message: "Adding answer is not possible")
        answerTextField.text = ""
        view.layoutIfNeeded()
    }
    
    func reloadTable() {
        answersTableView.reloadData()
    }
}

