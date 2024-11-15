//
//  RegistrationPageView.swift
//  Final Project
//
//  Created by YHY on 11/10/24.
//
import UIKit

class RegistrationPageView: UIView {
    
    var buttonLogin: UIButton!
    var buttonSignUp: UIButton!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .black

        setupbuttonLogin()
        setupbuttonSignUp()
        
        initConstraints()
    }

    func setupbuttonLogin(){
        buttonLogin = UIButton(type: .system)
        buttonLogin.setTitle("Log IN", for: .normal)
        buttonLogin.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonLogin.backgroundColor = UIColor.yellow
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonLogin)
    }
    
    func setupbuttonSignUp(){
        buttonSignUp = UIButton(type: .system)
        buttonSignUp.setTitle("Sign Up", for: .normal)
        buttonSignUp.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonSignUp.backgroundColor = UIColor.yellow
        buttonSignUp.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSignUp)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            
            buttonLogin.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            buttonLogin.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            buttonSignUp.topAnchor.constraint(equalTo: buttonLogin.bottomAnchor, constant: 32),
            buttonSignUp.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

