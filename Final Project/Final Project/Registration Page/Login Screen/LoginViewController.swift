//
//  LoginViewController.swift
//  Final Project
//
//  Created by YHY on 11/10/24.
//
import UIKit
import PhotosUI
import FirebaseStorage

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SKY DASH"
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 24, weight: .bold),
            .foregroundColor: UIColor.systemYellow
        ]
        //navigationController?.navigationBar.prefersLargeTitles = true
        
        loginView.buttonLogin.addTarget(self, action: #selector(onLoginTapped), for: .touchUpInside)
     
    }
    
    @objc func onLoginTapped(){
        //let VC = ViewController()
        //navigationController?.pushViewController(VC, animated: true)
    }
    
}
