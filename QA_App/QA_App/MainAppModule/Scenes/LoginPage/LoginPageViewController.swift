//
//  LoginPageViewController.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 30.11.24.
//

import UIKit

final class LoginPageViewController: UIViewController {
    private let titleLabel = UILabel()
    private let emailLabel = UILabel()
    private let usernameTextField = UITextField()
    private let passwordLabel = UILabel()
    private let forgotPasswordButton = UIButton()
    private let passwordTextField = UITextField()
    private let newToButton = UIButton()
    private let signUpButton = UIButton()
    private let loginButton = UIButton()
    private let privacyButton = UIButton()
    
    private let viewModel = LoginViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: AppAssets.Colors.background)
        setuptitleLabel()
        setupEmailLabel()
        setupUserNameTextField()
        setupPasswordLabel()
        setupForgotPasswordButton()
        setupPasswordTextField()
        setupNewToButton()
        setupSignUpButton()
        setupLoginButton()
        setupConstraints()
    }
    
    private func setuptitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        titleLabel.textColor = UIColor(named: AppAssets.Colors.bodyText)
        titleLabel.font = UIFont(name: MyFonts.anekBold.rawValue, size: 30)
        titleLabel.textAlignment = .center
        titleLabel.text = "Log in"
    }
     
    private func setupEmailLabel() {
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailLabel)
        
        emailLabel.textColor = UIColor(named: AppAssets.Colors.loginText)
        emailLabel.font = .systemFont(ofSize: 12)
        emailLabel.textAlignment = .left
        emailLabel.text = "Email"
    }
    
    private func setupUserNameTextField() {
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usernameTextField)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: usernameTextField.frame.height))
        usernameTextField.leftView = paddingView
        usernameTextField.leftViewMode = .always
        
        usernameTextField.placeholder = "Username"
        usernameTextField.layer.borderWidth = 1
        usernameTextField.layer.borderColor = UIColor(named: AppAssets.Colors.tabTitle)?.cgColor
        usernameTextField.layer.cornerRadius = 12
    }
    
    private func setupPasswordLabel() {
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordLabel)
        
        passwordLabel.textColor = UIColor(named: AppAssets.Colors.loginText)
        passwordLabel.font = .systemFont(ofSize: 12)
        passwordLabel.textAlignment = .left
        passwordLabel.text = "Password"
    }
    
    private func setupForgotPasswordButton() {
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(forgotPasswordButton)
        
        forgotPasswordButton.backgroundColor = .clear
        forgotPasswordButton.setTitle("Forgor Password?", for: .normal)
        forgotPasswordButton.titleLabel?.font = .systemFont(ofSize: 12)
        forgotPasswordButton.setTitleColor(UIColor(named: AppAssets.Colors.loginText), for: .normal)
    }
    
    private func setupPasswordTextField() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        let leftImage = UIImage(named: AppAssets.Icons.lock)
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 38, height: passwordTextField.frame.height))
        
        let leftImageView = UIImageView(image: leftImage)
        leftImageView.contentMode = .scaleAspectFit
        leftImageView.frame = CGRect(x: 10, y: -8, width: 15, height: 18)
        
        leftPaddingView.addSubview(leftImageView)
        
        let rightImage = UIImage(named: AppAssets.Icons.hiddenEye)
        privacyButton.setImage(rightImage, for: .normal)
        privacyButton.contentMode = .scaleAspectFit
        privacyButton.addTarget(self, action: #selector(privacyButtonTapped), for: .touchUpInside)
        
        
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 40))
                    
        privacyButton.frame = CGRect(x: 0, y: (rightPaddingView.bounds.height - 25) / 2, width: 30, height: 25)
        privacyButton.clipsToBounds = true

        
        rightPaddingView.addSubview(privacyButton)
        
        passwordTextField.leftView = leftPaddingView
        passwordTextField.rightView = rightPaddingView
        passwordTextField.leftViewMode = .always
        passwordTextField.rightViewMode = .always
        passwordTextField.isSecureTextEntry = true
        
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(named: AppAssets.Colors.tabTitle)?.cgColor
        passwordTextField.layer.cornerRadius = 12
    }
    
    @objc private func privacyButtonTapped() {
        passwordTextField.isSecureTextEntry.toggle()
        passwordTextField.layoutIfNeeded()
        print("pressed")
        
    }
    
    private func setupNewToButton() {
        newToButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newToButton)
        
        newToButton.backgroundColor = .clear
        newToButton.setTitle("New To Stay Connected?", for: .normal)
        newToButton.titleLabel?.font = .systemFont(ofSize: 12)
        newToButton.setTitleColor(UIColor(named: AppAssets.Colors.loginText), for: .normal)
    }
    
    private func setupSignUpButton() {
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signUpButton)
        
        signUpButton.backgroundColor = .clear
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.titleLabel?.font = UIFont(name: MyFonts.anekBold.rawValue, size: 18)
        signUpButton.setTitleColor(UIColor(named: AppAssets.Colors.loginText), for: .normal)
        
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
    }
    
    @objc private func signUpTapped() {
        let vc = SignUpPageViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        print("pressed")
    }
    
    private func setupLoginButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 16)
        loginButton.backgroundColor = UIColor(named: AppAssets.Colors.primaryButtonHighlighted)
        loginButton.layer.cornerRadius = 15
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        guard usernameTextField.text != "", usernameTextField.text != nil, usernameTextField.text?.isEmail() == true else {
            usernameTextField.layer.borderColor = UIColor.red.cgColor
            usernameTextField.shake()
            showAlert(title: "Incorrect Username Address", message: "Please Enter Valid Username")
            return
        }
        
        guard passwordTextField.text != "", passwordTextField.text != nil else {
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            passwordTextField.shake()
            showAlert(title: "Password Field Can't be Empthy", message: "Please Enter Valid Password")
            return
        }
        
        guard passwordTextField.text!.count >= 8 else {
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            passwordTextField.shake()
            showAlert(title: "Incorrect Password", message: "Please Enter Valid Password")
            return
        }
        
        let user = LoginRequest(email: usernameTextField.text!, password: passwordTextField.text!)
        
        viewModel.logIn(user: user) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: { [weak self] in
                    self?.navigateToHomePage()
                })
            case .failure(_):
                DispatchQueue.main.async {
                    self.loginFail()
                }
                print("failed to log in")
            }
        }
    }
    
    private func navigateToHomePage() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = TabBarController()
    }
    
    private func loginFail() {
        showAlert(title: "Unable To Log In", message: "Incorrect Username or Password")
        usernameTextField.layer.borderColor = UIColor.red.cgColor
        passwordTextField.layer.borderColor = UIColor.red.cgColor
        
        usernameTextField.shake()
        passwordTextField.shake()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -100),
            loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            loginButton.heightAnchor.constraint(equalTo: loginButton.widthAnchor, multiplier: 0.175),
            
            emailLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35),
            emailLabel.heightAnchor.constraint(equalToConstant: 15),
            
            titleLabel.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 180),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(greaterThanOrEqualTo: emailLabel.topAnchor, constant: -50),
            
            usernameTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            usernameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            usernameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            usernameTextField.heightAnchor.constraint(equalTo: usernameTextField.widthAnchor, multiplier: 0.155),
            
            passwordLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 45),
            passwordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            passwordLabel.heightAnchor.constraint(equalToConstant: 15),
            
            forgotPasswordButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            forgotPasswordButton.centerYAnchor.constraint(equalTo: passwordLabel.centerYAnchor),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 15),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            passwordTextField.heightAnchor.constraint(equalTo: passwordTextField.widthAnchor, multiplier: 0.155),
            
            newToButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            newToButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            newToButton.heightAnchor.constraint(equalToConstant: 15),
            
            signUpButton.centerYAnchor.constraint(equalTo: newToButton.centerYAnchor),
            signUpButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
        ])
    }

}
