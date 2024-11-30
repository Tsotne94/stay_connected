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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setupSearchBar()
        setupTags()
        setupTableView()
        setupConstraints()
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
        
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100
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
            
            table.topAnchor.constraint(equalTo: tagsCollection.bottomAnchor, constant: 10),
            table.leftAnchor.constraint(equalTo: leftAnchor),
            table.rightAnchor.constraint(equalTo: rightAnchor),
            table.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}

extension QuestionsTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionsTableViewCell.reuseIdentifier, for: indexPath) as! QuestionsTableViewCell
        return cell
    }
}
