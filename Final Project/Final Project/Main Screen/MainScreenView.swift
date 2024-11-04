//
//  MainScreenView.swift
//  Final Project
//
//  Created by Che-Yi Wu on 2024/11/3.
//

import UIKit

class MainScreenView: UIView {
    //MARK: Main Stackview
    var mainStackView: UIStackView!
    
    //MARK: Top stackview
    var mainTopStackView: UIStackView!
    var leftStackView: UIStackView!
    var rightStackView: UIStackView!
    
    //MARK: Middle stackview
    var middleStackView: UIStackView!
    
    //MARK: Bottom StackView
    var bottomStackView: UIStackView!
    
    var titleLabel: UILabel!
    var logoImageView: UIImageView!
    var friendsButton: UIButton!
    var profileButton: UIButton!
    var rankingButton: UIButton!
    var merchandiseButton: UIButton!
    var exitButton: UIButton!
    var startButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .rgb(0,0,28)
        
        setupTitleLabel()
        setupLogoImageView()
        setupFriendsButton()
        setupProfileButton()
        setupRankingButton()
        setUpMerchandiseButton()
        setUpExitButtonButton()
        setupStartButton()
        
        setupMainTopStackView()
        setupMiddleStackView()
        setupBottomStackView()
        setupMainStackView()
        
        initConstraints()
    }
    
    func setupMainTopStackView() {
        // Left Stack View for Title and Logo
        leftStackView = UIStackView(arrangedSubviews: [titleLabel, logoImageView])
        leftStackView.axis = .horizontal
        leftStackView.spacing = 8 // Adjust spacing as needed
        leftStackView.alignment = .center
        leftStackView.distribution = .fill
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Right Stack View for Friends and Profile Buttons
        rightStackView = UIStackView(arrangedSubviews: [friendsButton, profileButton])
        rightStackView.axis = .horizontal
        rightStackView.spacing = 32 // Adjust spacing as needed
        rightStackView.alignment = .center
        rightStackView.distribution = .fill
        rightStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Main Top Stack View with Left, Spacer, and Right Stack Views
        mainTopStackView = UIStackView(arrangedSubviews: [leftStackView, UIView(), rightStackView])
        mainTopStackView.axis = .horizontal
        mainTopStackView.spacing = 16 // Adjust if needed
        mainTopStackView.alignment = .center
        mainTopStackView.distribution = .fill
        mainTopStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupMiddleStackView() {
        middleStackView = UIStackView(arrangedSubviews: [rankingButton, merchandiseButton])
        middleStackView.axis = .vertical
        middleStackView.spacing = 2
        middleStackView.alignment = .leading
        middleStackView.distribution = .fill
        middleStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupBottomStackView() {
        bottomStackView = UIStackView(arrangedSubviews: [exitButton, UIView(),startButton])
        bottomStackView.axis = .horizontal
        bottomStackView.spacing = 0
        bottomStackView.alignment = .fill
        bottomStackView.distribution = .fill
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupMainStackView() {
        mainStackView = UIStackView(arrangedSubviews: [mainTopStackView, middleStackView, bottomStackView])
        mainStackView.axis = .vertical
        mainStackView.spacing = 40
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mainStackView)
    }
    
    func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "SKY DASH"
        titleLabel.font = .systemFont(ofSize:40, weight: .bold)
        titleLabel.textColor = .rgb(255, 209, 17)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false // Allow Auto Layout to control the label
//        self.addSubview(titleLabel)
    }
    
    func setupLogoImageView(){
        logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "appLogo")
        logoImageView.contentMode = .scaleToFill
        logoImageView.clipsToBounds = true
        logoImageView.layer.cornerRadius = 10
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(logoImageView)
    }
    
    func setupFriendsButton() {
        friendsButton = UIButton(type: .system)
        friendsButton.setImage(UIImage(systemName: "person.fill"), for: UIControl.State.normal)
        friendsButton.contentHorizontalAlignment = .fill
        friendsButton.contentVerticalAlignment = .fill
        friendsButton.imageView?.contentMode = .scaleAspectFit
        friendsButton.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(friendsButton)
    }
    
    func setupProfileButton() {
        profileButton = UIButton(type: .system)
        profileButton.setImage(UIImage(systemName: "person.circle.fill"), for: UIControl.State.normal)
        profileButton.contentHorizontalAlignment = .fill
        profileButton.contentVerticalAlignment = .fill
        profileButton.imageView?.contentMode = .scaleAspectFit
        profileButton.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(profileButton)
    }
    
    func setupRankingButton() {
        rankingButton = UIButton(type: .system)
        rankingButton.setTitle("Ranking", for: .normal)
        rankingButton.setTitleColor(.black, for: .normal)
        rankingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        // Center the text within the button's borders
        rankingButton.contentHorizontalAlignment = .center
        rankingButton.contentVerticalAlignment = .center

        rankingButton.imageView?.contentMode = .scaleAspectFit
        // Background color
        rankingButton.backgroundColor = .rgb(255, 209, 17)

        // Border settings
        rankingButton.layer.borderColor = UIColor.darkGray.cgColor
        rankingButton.layer.borderWidth = 2.0
        rankingButton.layer.cornerRadius = 10.0 // Rounded corners
        
        // Add menu to show in view
        rankingButton.showsMenuAsPrimaryAction = true
        rankingButton.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(rankingButton)
    }
    
    func setUpMerchandiseButton() {
        merchandiseButton = UIButton(type: .system)
        merchandiseButton.setTitle("Merchandise", for: .normal)
        merchandiseButton.setTitleColor(.black, for: .normal)
        merchandiseButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        // Center the text within the button's borders
        merchandiseButton.contentHorizontalAlignment = .center
        merchandiseButton.contentVerticalAlignment = .center

        merchandiseButton.imageView?.contentMode = .scaleAspectFit
        // Background color
        merchandiseButton.backgroundColor = .rgb(255, 209, 17)

        // Border settings
        merchandiseButton.layer.borderColor = UIColor.darkGray.cgColor
        merchandiseButton.layer.borderWidth = 2.0
        merchandiseButton.layer.cornerRadius = 10.0 // Rounded corners
        
        // Add menu to show in view
        merchandiseButton.showsMenuAsPrimaryAction = true
        merchandiseButton.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(merchandiseButton)
    }
    
    func setUpExitButtonButton() {
        exitButton = UIButton(type: .system)
        exitButton.setTitle("Exit", for: .normal)
        exitButton.setTitleColor(.black, for: .normal)
        exitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        // Center the text within the button's borders
        exitButton.contentHorizontalAlignment = .center
        exitButton.contentVerticalAlignment = .center

        exitButton.imageView?.contentMode = .scaleAspectFit
        // Background color
        exitButton.backgroundColor = .rgb(255, 209, 17)

        // Border settings
        exitButton.layer.borderColor = UIColor.darkGray.cgColor
        exitButton.layer.borderWidth = 2.0
        exitButton.layer.cornerRadius = 10.0 // Rounded corners
        
        // Add menu to show in view
        exitButton.showsMenuAsPrimaryAction = true
        exitButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupStartButton() {
        startButton = UIButton(type: .system)
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        // Center the text within the button's borders
        startButton.contentHorizontalAlignment = .center
        startButton.contentVerticalAlignment = .center

        startButton.imageView?.contentMode = .scaleAspectFit
        // Background color
        startButton.backgroundColor = .rgb(255, 209, 17)

        // Border settings
        startButton.layer.borderColor = UIColor.darkGray.cgColor
        startButton.layer.borderWidth = 2.0
        startButton.layer.cornerRadius = 10.0 // Rounded corners
        
        // Add menu to show in view
        startButton.showsMenuAsPrimaryAction = true
        startButton.translatesAutoresizingMaskIntoConstraints = false
    }

    //MARK: initializing the constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            // Main stack view constraints
            mainStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            // Additional constraints for subviews if necessary
            logoImageView.widthAnchor.constraint(equalToConstant: 50),
            logoImageView.heightAnchor.constraint(equalToConstant: 50),
            
            friendsButton.widthAnchor.constraint(equalToConstant: 50),
            friendsButton.heightAnchor.constraint(equalToConstant: 50),
            
            profileButton.widthAnchor.constraint(equalToConstant: 50),
            profileButton.heightAnchor.constraint(equalToConstant: 50),
            
            rankingButton.widthAnchor.constraint(equalToConstant: 200),
            rankingButton.heightAnchor.constraint(equalToConstant: 50),

            merchandiseButton.widthAnchor.constraint(equalToConstant: 200),
            merchandiseButton.heightAnchor.constraint(equalToConstant: 50),

            exitButton.widthAnchor.constraint(equalToConstant: 200),
            exitButton.heightAnchor.constraint(equalToConstant: 50),

            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 50),


        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIColor {
    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
}


