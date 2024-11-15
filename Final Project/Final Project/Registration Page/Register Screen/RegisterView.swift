//
//  RegisterView.swift
//  Final Project
//
//  Created by YHY on 11/13/24.
//

import UIKit

class RegisterView: UIView {
    var textFieldName: UITextField!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var textFieldConfirmPassword: UITextField!
    var textFieldUserID: UITextField!
    
    var labelSelfie:UILabel!
    var buttonTakeSelfie: UIButton!
    
    var buttonSignUp: UIButton!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .black
        
        setuptextFieldName()
        setuptextFieldEmail()
        setuptextFieldPassword()
        setupTextFieldConfirmPassword()
        setuptextFieldUserID()
        
        setuplabelSelfie()
        setupbuttonTakeSelfie()
        setupbuttonSignUp()
        
        initConstraints()
    }
    
    func setuptextFieldName(){
        textFieldName = UITextField()
        textFieldName.placeholder = "Name"
        textFieldName.textColor = UIColor.yellow
        textFieldName.keyboardType = .default
        textFieldName.borderStyle = .roundedRect
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldName)
    }
    
    func setuptextFieldEmail(){
        textFieldEmail = UITextField()
        textFieldEmail.placeholder = "Email"
        textFieldEmail.textColor = UIColor.yellow
        textFieldEmail.keyboardType = .default
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldEmail)
    }
    
    func setuptextFieldPassword(){
        textFieldPassword = UITextField()
        textFieldPassword.placeholder = "Password"
        textFieldPassword.textColor = UIColor.yellow
        textFieldPassword.textContentType = .password
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPassword)
    }
    
    func setupTextFieldConfirmPassword() {
        textFieldConfirmPassword = UITextField()
        textFieldConfirmPassword.placeholder = "Confirm Password"
        textFieldConfirmPassword.textColor = UIColor.yellow
        textFieldConfirmPassword.translatesAutoresizingMaskIntoConstraints = false
        textFieldConfirmPassword.borderStyle = .roundedRect
        textFieldConfirmPassword.isSecureTextEntry = true
        self.addSubview(textFieldConfirmPassword)
    }
    
    func setuptextFieldUserID(){
        textFieldUserID = UITextField()
        textFieldUserID.placeholder = "User ID"
        textFieldUserID.textColor = UIColor.yellow
        textFieldUserID.keyboardType = .emailAddress
        textFieldUserID.borderStyle = .roundedRect
        textFieldUserID.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldUserID)
    }
    
    
    func setuplabelSelfie(){
        labelSelfie = UILabel()
        labelSelfie.text = "Add your photo"
        labelSelfie.textColor = UIColor.yellow
        labelSelfie.font = UIFont.boldSystemFont(ofSize: 14)
        labelSelfie.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelSelfie)
    }
    
    func setupbuttonTakeSelfie(){
        buttonTakeSelfie = UIButton(type: .system)
        buttonTakeSelfie.setTitle("", for: .normal)
        buttonTakeSelfie.setImage(UIImage(systemName: "person.fill.viewfinder")?.withRenderingMode(.alwaysOriginal), for: .normal)
        buttonTakeSelfie.contentHorizontalAlignment = .fill
        buttonTakeSelfie.contentVerticalAlignment = .fill
        buttonTakeSelfie.imageView?.contentMode = .scaleAspectFit
        buttonTakeSelfie.showsMenuAsPrimaryAction = true
        buttonTakeSelfie.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonTakeSelfie)
    }
    
    func setupbuttonSignUp(){
        buttonSignUp = UIButton(type: .system)
        buttonSignUp.setTitle("Sign Up", for: .normal)
        buttonSignUp.backgroundColor = UIColor.yellow
        buttonSignUp.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonSignUp.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSignUp)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            textFieldName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            textFieldName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldName.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
            textFieldEmail.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 16),
            textFieldEmail.centerXAnchor.constraint(equalTo:self.safeAreaLayoutGuide.centerXAnchor),
            textFieldEmail.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
            textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 16),
            textFieldPassword.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldPassword.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
            textFieldConfirmPassword.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 16),
            textFieldConfirmPassword.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldConfirmPassword.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
            textFieldUserID.topAnchor.constraint(equalTo: textFieldConfirmPassword.bottomAnchor, constant: 16),
            textFieldUserID.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldUserID.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
     
            buttonSignUp.topAnchor.constraint(equalTo: textFieldUserID.bottomAnchor, constant: 32),
            buttonSignUp.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            buttonTakeSelfie.topAnchor.constraint(equalTo: labelSelfie.topAnchor, constant: 16),
            buttonTakeSelfie.leadingAnchor.constraint(equalTo: textFieldName.trailingAnchor, constant: 10),
            buttonTakeSelfie.widthAnchor.constraint(equalToConstant: 100),
            buttonTakeSelfie.heightAnchor.constraint(equalToConstant: 100),
            
            labelSelfie.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            labelSelfie.leadingAnchor.constraint(equalTo: buttonTakeSelfie.leadingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

