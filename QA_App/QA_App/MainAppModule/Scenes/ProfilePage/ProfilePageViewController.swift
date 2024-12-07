//
//  ProfilePageViewController.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 29.11.24.
//

import UIKit

class ProfilePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, IdentifiableProtocol {

    private let imageView = UIImageView()
    private let fullnameLabel = UILabel()
    private let emailLabel = UILabel()
    private let tableView = UITableView()
    private let titleLabel = UILabel()
    private let imageButton = UIButton()

    private let viewModel = ProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        setupUI()
        bindViewModel()
        viewModel.fetchUserProfile()
    }

    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            self?.updateUI()
        }
    }

    private func updateUI() {
        fullnameLabel.text = viewModel.userProfile?.fullName ?? "No Name"
        emailLabel.text = viewModel.userProfile?.email ?? "No Email"
        tableView.reloadData()

    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func setupUI() {
        setupTitle()
        setupImageView()
        setupImageButton()
        setupFullnameLabel()
        setupEmailLabel()
        setupTableView()
        setupConstraints()
    }

    private func setupTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        titleLabel.text = "Profile"
        titleLabel.font = UIFont(name: MyFonts.anekBold.rawValue, size: 20)
        titleLabel.textAlignment = .left
    }

    private func setupImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.layer.cornerRadius = 60
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
    }

    private func setupImageButton() {
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageButton)

        imageButton.setImage(UIImage(named: AppAssets.Icons.camera), for: .normal)
        imageButton.setTitle("", for: .normal)
        imageButton.backgroundColor = .clear
        imageButton.clipsToBounds = true
    }

    private func setupFullnameLabel() {
        view.addSubview(fullnameLabel)
        fullnameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullnameLabel.textColor = .black
        fullnameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        fullnameLabel.textAlignment = .center
        fullnameLabel.text = "Loading..."
    }

    private func setupEmailLabel() {
        view.addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.textColor = .darkGray
        emailLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        emailLabel.textAlignment = .center
        emailLabel.text = "Loading..."
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProfileCell.self, forCellReuseIdentifier: "ProfileCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.isScrollEnabled = false
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),

            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.175),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 121),

            imageButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            imageButton.rightAnchor.constraint(equalTo: imageView.rightAnchor),

            fullnameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 33),
            fullnameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            emailLabel.topAnchor.constraint(equalTo: fullnameLabel.bottomAnchor, constant: 8),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            tableView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 49),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileCell else {
            return UITableViewCell()
        }

        switch indexPath.row {
        case 0:
            let score = viewModel.userProfile?.score ?? 7
            cell.configureCell(leftText: "Score", rightText: "\(score)", icon: nil)
            cell.selectionStyle = .none
        case 1:
            let answeredQuestions = viewModel.userProfile?.answeredQuestionsCount ?? 7
            cell.configureCell(leftText: "Answered Questions", rightText: "\(answeredQuestions)", icon: nil)
            cell.selectionStyle = .none
        case 2:
            cell.configureCell(leftText: "Log out", rightText: nil, icon: UIImage(named: "logOutIcon"))
            cell.selectionStyle = .default
        default:
            break
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Information"
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            KeyChainManager.deleteAllKeychainItems()
            navigateToLoginPage()

        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    private func navigateToLoginPage() {
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: LoginPageViewController())
        }
    
}
