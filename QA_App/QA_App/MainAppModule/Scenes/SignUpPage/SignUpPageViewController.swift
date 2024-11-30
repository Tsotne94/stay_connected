//
//  SignUpPageViewController.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 30.11.24.
//
import UIKit

class SignUpPageViewController: UIViewController {
    private let titleLabel = UILabel()
    private let fullNameLabel = UILabel()
    private let nameTextField = UITextField()
    private let emailLabel = UILabel()
    private let usernameTextField = UITextField()
    private let enterPaswordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let confirmPasswordLabel = UILabel()
    private let confirmPasswordTextfield = UITextField()
    private let signUpButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: AppAssets.Colors.background)
        setupTitleLabel()
        setupFullNameLabel()
        setupNameTextField()
        setupEmailLabel()
        setupUsernameTextfield()
        setupEnterPasswordLabel()
        setupPasswordTextField()
        setupConfirmPasswordLabel()
        setupConfirmPasswordTextField()
        setupSignUpButton()
        setupConstraints()
    }
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        titleLabel.textColor = UIColor(named: AppAssets.Colors.bodyText)
        titleLabel.font = .systemFont(ofSize: 32)
        titleLabel.textAlignment = .left
        titleLabel.text = "Sign Up"
    }
    
    private func setupFullNameLabel() {
        setupLabel(fullNameLabel, title: "Full Name")
    }
    
    private func setupNameTextField() {
        setupTextField(nameTextField, placeholder: "Name")
    }
     
    private func setupEmailLabel() {
        setupLabel(emailLabel, title: "Email")
    }
    
    private func setupUsernameTextfield() {
        setupTextField(usernameTextField, placeholder: "Username")
    }
    
    private func setupEnterPasswordLabel() {
        setupLabel(enterPaswordLabel, title: "Enter Password")
    }
    
    private func setupPasswordTextField() {
        setupSecureTextField(passwordTextField, placeholder: "Password")
    }
    
    private func setupConfirmPasswordLabel() {
        setupLabel(confirmPasswordLabel, title: "Confirm Password")
    }
    
    private func setupConfirmPasswordTextField() {
        setupSecureTextField(confirmPasswordTextfield, placeholder: "Password")
    }
    
    private func setupTextField(_ textField: UITextField, placeholder: String?) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        textField.placeholder = placeholder ?? ""
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: AppAssets.Colors.tabTitle)?.cgColor
        textField.layer.cornerRadius = 12
    }
    
    private func setupSecureTextField(_ textField: UITextField, placeholder: String?) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        
        let leftImage = UIImage(named: AppAssets.Icons.lock)
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 38, height: textField.frame.height))
        
        let leftImageView = UIImageView(image: leftImage)
        leftImageView.contentMode = .scaleAspectFit
        leftImageView.frame = CGRect(x: 10, y: -8, width: 15, height: 18)
        
        leftPaddingView.addSubview(leftImageView)
        
        let rightImage = UIImage(named: AppAssets.Icons.hiddenEye)
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        
        let rightImageView = UIImageView(image: rightImage)
        rightImageView.contentMode = .scaleAspectFit
        rightImageView.frame = CGRect(x: -10, y: -8, width: 16, height: 16)
        
        rightPaddingView.addSubview(rightImageView)
        
        textField.leftView = leftPaddingView
        textField.rightView = rightPaddingView
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.isSecureTextEntry = true
        
        textField.placeholder = placeholder ?? ""
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: AppAssets.Colors.tabTitle)?.cgColor
        textField.layer.cornerRadius = 12
    }
    
    private func setupLabel(_ label: UILabel, title: String) {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.textColor = UIColor(named: AppAssets.Colors.loginText)
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .left
        label.text = title
    }
    
    private func setupSignUpButton() {
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signUpButton)
        
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.titleLabel?.font = .systemFont(ofSize: 16)
        signUpButton.backgroundColor = UIColor(named: AppAssets.Colors.primaryButtonHighlighted)
        signUpButton.layer.cornerRadius = 15
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            fullNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            fullNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 15),
            
            nameTextField.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 8),
            nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            nameTextField.heightAnchor.constraint(equalTo: nameTextField.widthAnchor, multiplier: 0.155),
            
            emailLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30),
            emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            emailLabel.heightAnchor.constraint(equalToConstant: 15),
            
            usernameTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            usernameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            usernameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            usernameTextField.heightAnchor.constraint(equalTo: usernameTextField.widthAnchor, multiplier: 0.155),
            
            enterPaswordLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30),
            enterPaswordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            enterPaswordLabel.heightAnchor.constraint(equalToConstant: 15),
            
            passwordTextField.topAnchor.constraint(equalTo: enterPaswordLabel.bottomAnchor, constant: 8),
            passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            passwordTextField.heightAnchor.constraint(equalTo: passwordTextField.widthAnchor, multiplier: 0.155),
            
            confirmPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            confirmPasswordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            confirmPasswordLabel.heightAnchor.constraint(equalToConstant: 15),
            
            confirmPasswordTextfield.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 8),
            confirmPasswordTextfield.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            confirmPasswordTextfield.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            confirmPasswordTextfield.heightAnchor.constraint(equalTo: confirmPasswordTextfield.widthAnchor, multiplier: 0.155),
            
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(view.frame.height * 0.115)),
            signUpButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            signUpButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            signUpButton.heightAnchor.constraint(equalTo: signUpButton.widthAnchor, multiplier: 0.175)
        ])
    }
}
