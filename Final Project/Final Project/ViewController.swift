//
//  ViewController.swift
//  Final Project
//
//  Created by Che-Yi Wu on 2024/10/16.
//

import UIKit

class ViewController: UIViewController {
    let loginView = LoginView()

    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // type something
        title = "Login"
        
        loginView.loginButton.addTarget(self, action: #selector(onAddBarButtonTapped), for: .touchUpInside)

    }

    @objc func onAddBarButtonTapped(){
        //MARK: Put your own controller here to navigate to test
//        let addContactController = AddContactController()
//        addContactController.delegate = self
//        navigationController?.pushViewController(addContactController, animated: true)
        
        // test
        // test
    }

}

