//
//  ProfilePageViewController.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 29.11.24.
//

import UIKit
class ProfilePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, IdentifiableProtocol {

    private let ImageView = UIImageView()
    private let FullnameLabel = UILabel()
    private let EmailLabel = UILabel()
    private let tableView = UITableView()
    private let titleLabel = UILabel()
    private let imageButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        setupUI()
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
        view.addSubview(ImageView)
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.image = UIImage(systemName: "person.crop.circle.fill")
        ImageView.contentMode = .scaleAspectFit
        ImageView.tintColor = .white
        ImageView.layer.cornerRadius = 60
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .gray
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
        view.addSubview(FullnameLabel)
        FullnameLabel.translatesAutoresizingMaskIntoConstraints = false
        FullnameLabel.textColor = .black
        FullnameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        FullnameLabel.textAlignment = .center
        FullnameLabel.text = "Shawn Howard"
    }

    private func setupEmailLabel() {
        view.addSubview(EmailLabel)
        EmailLabel.translatesAutoresizingMaskIntoConstraints = false
        EmailLabel.textColor = .darkGray
        EmailLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        EmailLabel.textAlignment = .center
        EmailLabel.text = "shawn_howard@gmail.com"
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
            
            ImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.175),
            ImageView.widthAnchor.constraint(equalToConstant: 120),
            ImageView.heightAnchor.constraint(equalToConstant: 121),
            
            imageButton.bottomAnchor.constraint(equalTo: ImageView.bottomAnchor),
            imageButton.rightAnchor.constraint(equalTo: ImageView.rightAnchor),

            FullnameLabel.topAnchor.constraint(equalTo: ImageView.bottomAnchor, constant: 33),
            FullnameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            EmailLabel.topAnchor.constraint(equalTo: FullnameLabel.bottomAnchor, constant: 8),
            EmailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            tableView.topAnchor.constraint(equalTo: EmailLabel.bottomAnchor, constant: 49),
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
            cell.configureCell(leftText: "Score", rightText: "25", icon: nil)
            cell.selectionStyle = .none
        case 1:
            cell.configureCell(leftText: "Answered Questions", rightText: "15", icon: nil)
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
            print("Log out")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

