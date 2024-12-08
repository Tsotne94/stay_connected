//
//  LeaderBoardViewController.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 08.12.24.
//
import UIKit

protocol LeaderReload: AnyObject {
    func reload()
}

class LeaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, IdentifiableProtocol {
    private let titleLabel = UILabel()
    private var tableView: UITableView!
    private var viewModel: LeaderBoardViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        setupTitleLabel()
        viewModel = LeaderBoardViewModel()
        viewModel?.delegate = self
        setupTableView()
    }
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        titleLabel.text = "LeaderBoard"
        titleLabel.font = UIFont(name: MyFonts.anekBold.rawValue, size: 20)
        titleLabel.textAlignment = .left
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LeaderboardTableViewCell.self, forCellReuseIdentifier: "LeaderboardTableViewCell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.usersCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardTableViewCell", for: indexPath) as! LeaderboardTableViewCell
        guard let user = viewModel?.singleUser(at: indexPath.row) else { return cell }
        cell.configure(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension LeaderboardViewController: LeaderReload {
    func reload() {
        tableView.reloadData()
    }
}
