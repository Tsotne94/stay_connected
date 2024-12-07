//
//  AddQuestionViewController.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 02.12.24.
//

import UIKit

protocol UpdateQuestions: AnyObject {
    func update()
}

class AddQuestionViewController: UIViewController {
    private let titleLabel = UILabel()
    private let titleContainerView = UIView()
    private let cancelButton = UIButton()
    
    private let subjectContainer = UIView()
    private let subjectLabel = UILabel()
    private let subjectTextField = UITextField()

    
    private let tagContainer = UIView()
    private let tagLabel = UILabel()
    private let selectedTags = TagsCollectionView()
    
    private let allTags = AddQuestionTagsCollection()
    private var viewmodel: AddQuestionViewModel?
    
    private let questionTextField = UITextView()
    private let questionButton = UIButton()
    private let placeholderLabel = UILabel()
    weak var delegate: UpdateQuestions?
    
  
    private var selectedTagsItems: [Tag] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewmodel = AddQuestionViewModel()
        viewmodel?.delegate = self
        allTags.delegate = self
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.update()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        
        setupTitleContainer()
        setupTitleLabel()
        setupCancelButton()
        setupSubjectContainer()
        setupTagContainer()
        setupallTags()
        setupTextFields()
        setupConstraints()
        setupPlaceholder()
        setupSendButton()

    }
    
    private func setupPlaceholder() {
            placeholderLabel.text = "Type your question here"
            placeholderLabel.textColor = .lightGray
            placeholderLabel.font = .systemFont(ofSize: 15, weight: .regular)
            placeholderLabel.isUserInteractionEnabled = false
            
            questionTextField.addSubview(placeholderLabel)
            
            placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                placeholderLabel.topAnchor.constraint(equalTo: questionTextField.topAnchor, constant: 8),
                placeholderLabel.leftAnchor.constraint(equalTo: questionTextField.leftAnchor, constant: 10)
            ])
            
            updatePlaceholderVisibility()
        }
        
        private func updatePlaceholderVisibility() {
            placeholderLabel.isHidden = !questionTextField.text.isEmpty
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
    
    private func setupCancelButton() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        titleContainerView.addSubview(cancelButton)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor(named: AppAssets.Colors.primaryButtonHighlighted), for: .normal)
        cancelButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    private func setupSubjectContainer() {
        subjectContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subjectContainer)
        createSeparatorLine(for: subjectContainer, top: true)
        
        subjectLabel.translatesAutoresizingMaskIntoConstraints = false
        subjectContainer.addSubview(subjectLabel)
        subjectLabel.text = "Subject:"
        subjectLabel.textColor = .lightGray
        subjectLabel.font = .systemFont(ofSize: 15, weight: .regular)
        
        subjectTextField.translatesAutoresizingMaskIntoConstraints = false
        subjectContainer.addSubview(subjectTextField)
        subjectTextField.textColor = .lightGray
        subjectTextField.font = .systemFont(ofSize: 15, weight: .regular)
        subjectTextField.backgroundColor = .clear
    }
    
    private func setupTagContainer() {
        tagContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tagContainer)
        createSeparatorLine(for: tagContainer, top: true)
        createSeparatorLine(for: tagContainer, top: false)
        
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        tagContainer.addSubview(tagLabel)
        tagLabel.text = "Tags:"
        tagLabel.textColor = .lightGray
        tagLabel.font = .systemFont(ofSize: 15, weight: .regular)
        
        selectedTags.translatesAutoresizingMaskIntoConstraints = false
        selectedTags.disableUserInteraction()
        tagContainer.addSubview(selectedTags)
    }
    
    private func setupallTags() {
        allTags.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(allTags)
    }
    
    private func createSeparatorLine(for customView: UIView, top: Bool) {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        separator.translatesAutoresizingMaskIntoConstraints = false
        customView.addSubview(separator)
        
        if top {
            NSLayoutConstraint.activate([
                separator.heightAnchor.constraint(equalToConstant: 1),
                separator.leftAnchor.constraint(equalTo: customView.leftAnchor),
                separator.rightAnchor.constraint(equalTo: customView.rightAnchor),
                separator.bottomAnchor.constraint(equalTo: customView.topAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                separator.heightAnchor.constraint(equalToConstant: 1),
                separator.leftAnchor.constraint(equalTo: customView.leftAnchor),
                separator.rightAnchor.constraint(equalTo: customView.rightAnchor),
                separator.bottomAnchor.constraint(equalTo: customView.bottomAnchor)
            ])
        }
    }
    
    private func setupTextFields() {
        questionTextField.layer.borderWidth = 1
        questionTextField.layer.borderColor = UIColor(named: AppAssets.Colors.tabTitle)?.cgColor
        questionTextField.layer.cornerRadius = 12
        
        questionTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionTextField)
        
        questionTextField.delegate = self
        questionTextField.isScrollEnabled = false
        questionTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        questionTextField.textColor = .lightGray
        questionTextField.textContainerInset = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 35)
        questionTextField.textContainer.lineFragmentPadding = 0


    }
    
    private func setupPadding(for searchBar: UITextField) {
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 40))
        questionButton.setImage(UIImage(named: AppAssets.Icons.sendMessage), for: .normal)
        questionButton.tintColor = .gray
                    
        questionButton.frame = CGRect(x: 0, y: (rightPaddingView.bounds.height - 25) / 2, width: 30, height: 25)
        questionButton.clipsToBounds = true
        rightPaddingView.addSubview(questionButton)
        rightPaddingView.isUserInteractionEnabled = true
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: searchBar.frame.height))
        
        searchBar.rightView = rightPaddingView
        searchBar.rightViewMode = .always
        
        searchBar.leftView = leftPaddingView
        searchBar.leftViewMode = .always
        
    }
    
    private func setupSendButton() {
        let sendButton = UIButton()
        sendButton.setImage(UIImage(named: AppAssets.Icons.sendMessage), for: .normal)
        sendButton.tintColor = .gray
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sendButton)
        
        sendButton.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            sendButton.topAnchor.constraint(equalTo: questionTextField.topAnchor),
            sendButton.rightAnchor.constraint(equalTo: questionTextField.rightAnchor, constant: -5),
            sendButton.heightAnchor.constraint(equalToConstant: 30),
            sendButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        questionButton.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)

    }
    
    @objc private func sendPressed() {
        guard let title = subjectTextField.text else { return }
        guard let content = questionTextField.text else { return }
        let tags = selectedTagsItems.map({ $0.id })
        guard tags.isEmpty == false else {
            showAlert(title: "No Tags Were Selected", message: "You Must Select At Least One Tag")
            return
        }
        let question = AddQuestionModel(title: title, content: content, tags: tags)

        viewmodel?.addQuestion(question: question)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            titleContainerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            titleContainerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            titleContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.09),
            
            titleLabel.centerXAnchor.constraint(equalTo: titleContainerView.centerXAnchor, constant: -25),
            titleLabel.centerYAnchor.constraint(equalTo: titleContainerView.centerYAnchor),
            
            cancelButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            cancelButton.rightAnchor.constraint(equalTo: titleContainerView.rightAnchor, constant: -16),
            
            subjectContainer.topAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            subjectContainer.leftAnchor.constraint(equalTo: view.leftAnchor),
            subjectContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            subjectContainer.heightAnchor.constraint(equalTo: titleContainerView.heightAnchor, multiplier: 0.61),
            
            subjectLabel.leftAnchor.constraint(equalTo: subjectContainer.leftAnchor, constant: 8),
            subjectLabel.centerYAnchor.constraint(equalTo: subjectContainer.centerYAnchor),
            subjectLabel.heightAnchor.constraint(equalTo: subjectLabel.heightAnchor),
            subjectLabel.widthAnchor.constraint(equalTo: subjectContainer.widthAnchor, multiplier: 0.15),
            
            subjectTextField.leftAnchor.constraint(equalTo: subjectLabel.rightAnchor, constant: 8),
            subjectTextField.rightAnchor.constraint(equalTo: subjectContainer.rightAnchor, constant: -5),
            subjectTextField.centerYAnchor.constraint(equalTo: subjectContainer.centerYAnchor),
            subjectTextField.heightAnchor.constraint(equalTo: subjectContainer.heightAnchor),
            
            tagContainer.topAnchor.constraint(equalTo: subjectContainer.bottomAnchor),
            tagContainer.leftAnchor.constraint(equalTo: view.leftAnchor),
            tagContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            tagContainer.heightAnchor.constraint(greaterThanOrEqualTo: titleContainerView.heightAnchor, multiplier: 0.61),
            
            tagLabel.leftAnchor.constraint(equalTo: tagContainer.leftAnchor, constant: 8),
            tagLabel.centerYAnchor.constraint(equalTo: tagContainer.centerYAnchor),
            
            selectedTags.leftAnchor.constraint(equalTo: tagLabel.rightAnchor, constant: 8),
            selectedTags.centerYAnchor.constraint(equalTo: tagLabel.centerYAnchor),
            selectedTags.rightAnchor.constraint(equalTo: tagContainer.rightAnchor, constant: -5),
            
            selectedTags.heightAnchor.constraint(equalTo: titleContainerView.heightAnchor, multiplier: 0.61),
            
            allTags.topAnchor.constraint(equalTo: tagContainer.bottomAnchor, constant: 10),
            allTags.leftAnchor.constraint(equalTo: view.leftAnchor),
            allTags.rightAnchor.constraint(equalTo: view.rightAnchor),
            allTags.heightAnchor.constraint(equalTo: allTags.widthAnchor, multiplier: 0.17),
            
            questionTextField.topAnchor.constraint(equalTo: allTags.bottomAnchor, constant: 30),
            questionTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            questionTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            questionTextField.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
}


extension AddQuestionViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        questionTextField.adjustHeight()
        updatePlaceholderVisibility()
    }
}

extension AddQuestionViewController: AddQUestion {
    func success() {
        showAlert(title: "Question Added Successfully", message: "Question Was Added")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            self.dismiss(animated: true)
            self.dismiss(animated: true)
        })
    }
    
    func reload() {
        allTags.updateTags(viewmodel?.tags() ?? [])
    }
}

extension AddQuestionViewController: AddQuestionTagsCollectionDelegate {
    func removeTag(_ tag: Tag) {
        selectedTagsItems.removeAll(where: { $0.name == tag.name })
        selectedTags.updateTags(selectedTagsItems)
    }
    
    func didSelectTag(_ tag: Tag) {
        selectedTagsItems.append(tag)
        selectedTags.updateTags(selectedTagsItems)
    }
}
