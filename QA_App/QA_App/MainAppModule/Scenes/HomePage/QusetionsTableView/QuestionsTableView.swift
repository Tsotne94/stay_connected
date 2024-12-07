//
//  QuestionsTableView.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 30.11.24.
//

import UIKit

protocol ReloadTable: AnyObject {
    func reloadTable()
    func reload()
}

class QuestionsTableView: UIView {
    private let searchBar = UISearchBar()
    private let table = UITableView()
    
    private let noQuestionsLabel = UILabel()
    private let beFirstLabel = UILabel()
    private let backImage = UIImageView()
    private var viewModel: QuestionProtocol?
    private var tagsCollection: TagsCollectionView?
    weak var delegate: QuestionsTableViewDelegate?
    
    init(viewModel: QuestionProtocol) {
            self.viewModel = viewModel
            super.init(frame: .zero)
            self.tagsCollection = TagsCollectionView()  
            setupView()
            
            if let homePageViewModel = viewModel as? HomePageViewModel {
                homePageViewModel.delegate = self
            }
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        if viewModel?.questionQount ?? 0 >= 0 {
            setupSearchBar()
            setupTags()
            setupTableView()
            setupConstraints()
        }
        else {
            setupFirstLabel()
            setupSecondLabel()
            setupBackgroundPicture()
            setupEmpthyConstraints()
        }
    }
    
    private func setupSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchBar)
        
        searchBar.placeholder = "Search"
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
    }
    
    private func setupTags() {
        tagsCollection?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tagsCollection ?? UIView())
        tagsCollection?.delegate = viewModel as? HomePageViewModel
    }
    
    private func setupTableView() {
        table.translatesAutoresizingMaskIntoConstraints = false
        addSubview(table)
        
        table.clipsToBounds = true
        table.layer.cornerRadius = 22
        table.backgroundColor = .background
        table.separatorStyle = .none
        
        table.register(QuestionsTableViewCell.self, forCellReuseIdentifier: QuestionsTableViewCell.reuseIdentifier)
        table.delegate = self
        table.dataSource = self
        
        table.rowHeight = 115
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            tagsCollection!.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tagsCollection!.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            tagsCollection!.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            tagsCollection!.heightAnchor.constraint(equalToConstant: 40),
            
            table.topAnchor.constraint(equalTo: tagsCollection?.bottomAnchor ?? topAnchor, constant: 5),
            table.leftAnchor.constraint(equalTo: leftAnchor),
            table.rightAnchor.constraint(equalTo: rightAnchor),
            table.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupFirstLabel() {
        noQuestionsLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(noQuestionsLabel)
        
        noQuestionsLabel.text = "No questions yet"
        noQuestionsLabel.textColor = UIColor(named: AppAssets.Colors.emptyStateText)
        noQuestionsLabel.textAlignment = .center
        noQuestionsLabel.font = .systemFont(ofSize: 15, weight: .medium)
    }
    
    private func setupSecondLabel() {
        beFirstLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(beFirstLabel)
        
        beFirstLabel.text = "Be the first to ask one"
        beFirstLabel.textColor = UIColor(named: AppAssets.Colors.bodyText)
        beFirstLabel.textAlignment = .center
        beFirstLabel.font = .systemFont(ofSize: 15, weight: .medium)
    }
    
    private func setupBackgroundPicture() {
        backImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backImage)
        
        backImage.image = UIImage(named: AppAssets.Icons.noContentBackground)
        backImage.backgroundColor = .clear
        backImage.contentMode = .scaleAspectFit
        backImage.clipsToBounds = true
    }
    
    private func setupEmpthyConstraints() {
        NSLayoutConstraint.activate([
            backImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -110),
            backImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            beFirstLabel.bottomAnchor.constraint(equalTo: backImage.topAnchor, constant: -8),
            beFirstLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            noQuestionsLabel.bottomAnchor.constraint(equalTo: beFirstLabel.topAnchor, constant: -8),
            noQuestionsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}

extension QuestionsTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.questionQount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionsTableViewCell.reuseIdentifier, for: indexPath) as! QuestionsTableViewCell
        guard let question = viewModel?.singleQuestion(at: indexPath.row) else { return cell }
        cell.configure(with: question)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let question = viewModel?.singleQuestion(at: indexPath.row) else { return }
        delegate?.didSelectQuestion(question: question)
    }
}

extension QuestionsTableView: ReloadTable {
    func reloadTable() {
        DispatchQueue.main.async { [weak self] in
            self?.table.reloadData()
        }
    }
    
    func reload() {
        DispatchQueue.main.async { [weak self] in
            self!.tagsCollection?.updateTags(self?.viewModel?.tags() ?? [])
        }
    }
}

extension QuestionsTableView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let homePageViewModel = viewModel as? HomePageViewModel {
            let tag = tagsCollection?.getTag()
            homePageViewModel.fetchQuestions(tag: tag, search: searchText)
        }
    }
}
