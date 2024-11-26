//
//  DisplayUserProfileView.swift
//  WA8_40
//
//  Created by jocw on 11/27/24.
//

import UIKit

class DisplayUserProfileView: UIView {
    var titleLabel: UILabel!
    var userNameTextField: UITextField!
    var passwordTextField: UITextField!
    var editProfileButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .rgb(0,0,28) // Assuming you have the rgb extension
        
        setupTitleLabel()
        setupUserNameTextField()
        setupPasswordTextField()
        setupEditProfileButton()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Display User Profile"
        titleLabel.font = .boldSystemFont(ofSize: 32)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
    }
    
    func setupUserNameTextField() {
        userNameTextField = UITextField()
        userNameTextField.placeholder = "Username"
        userNameTextField.borderStyle = .roundedRect
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(userNameTextField)
    }
    
    func setupPasswordTextField() {
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(passwordTextField)
    }
    
    func setupEditProfileButton() {
        editProfileButton = UIButton(type: .system)
        editProfileButton.setTitle("Edit Profile", for: .normal)
        editProfileButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        editProfileButton.setTitleColor(.white, for: .normal)
        editProfileButton.backgroundColor = .systemBlue
        editProfileButton.layer.cornerRadius = 5
        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(editProfileButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Title Label constraints
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            // Username TextField constraints
            userNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            userNameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            userNameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            userNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Password TextField constraints
            passwordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Edit Profile Button constraints
            editProfileButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            editProfileButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            editProfileButton.widthAnchor.constraint(equalToConstant: 120),
            editProfileButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}