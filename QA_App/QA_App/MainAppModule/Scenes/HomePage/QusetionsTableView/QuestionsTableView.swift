//
//  QuestionsTableView.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 30.11.24.
//

import UIKit

class QuestionsTableView: UIView {
    private let searchBar = UISearchBar()
    private let tagsCollection = TagsCollectionView()
    private let table = UITableView()
    private let tableCount = 10
    
    private let noQuestionsLabel = UILabel()
    private let beFirstLabel = UILabel()
    private let backImage = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        if tableCount > 0 {
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
    }
    
    private func setupTags() {
        tagsCollection.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tagsCollection)
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
            
            tagsCollection.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tagsCollection.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            tagsCollection.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            tagsCollection.heightAnchor.constraint(equalToConstant: 40),
            
            table.topAnchor.constraint(equalTo: tagsCollection.bottomAnchor, constant: 5),
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
        tableCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionsTableViewCell.reuseIdentifier, for: indexPath) as! QuestionsTableViewCell
        return cell
    }
}
