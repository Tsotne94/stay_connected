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
    private let LoginButton = UIButton()
    

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
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: passwordTextField.frame.height))
        
        let rightImageView = UIImageView(image: rightImage)
        rightImageView.contentMode = .scaleAspectFit
        rightImageView.frame = CGRect(x: -10, y: -8, width: 16, height: 16)
        
        rightPaddingView.addSubview(rightImageView)
        
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
    }
    
    private func setupLoginButton() {
        LoginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(LoginButton)
        
        LoginButton.setTitle("Log In", for: .normal)
        LoginButton.setTitleColor(.white, for: .normal)
        LoginButton.titleLabel?.font = .systemFont(ofSize: 16)
        LoginButton.backgroundColor = UIColor(named: AppAssets.Colors.primaryButtonHighlighted)
        LoginButton.layer.cornerRadius = 15
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            LoginButton.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -100),
            LoginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            LoginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            LoginButton.heightAnchor.constraint(equalTo: LoginButton.widthAnchor, multiplier: 0.175),
            
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
