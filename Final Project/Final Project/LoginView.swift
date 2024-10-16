//
//  LoginView.swift
//  Final Project
//
//  Created by Che-Yi Wu on 2024/10/16.
//

import UIKit

class LoginView: UIView {
    var loginButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        //MARK: initializing a TableView...
        setupLoginButton()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLoginButton(){
        loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        loginButton.imageView?.contentMode = .scaleAspectFit
        // Add menu to show in view
        loginButton.showsMenuAsPrimaryAction = true
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loginButton)

    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            loginButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            loginButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            loginButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
    }

}
