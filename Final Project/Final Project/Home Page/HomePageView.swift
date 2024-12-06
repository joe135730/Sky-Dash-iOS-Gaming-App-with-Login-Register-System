//
//  HomePageView.swift
//  WA8_40
//
//  Created by jocw on 11/27/24.
//

import UIKit

class HomePageView: UIView {
    
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
        middleStackView = UIStackView(arrangedSubviews: [rankingButton])
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
    }
    
    func setupLogoImageView(){
        logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "appLogo")
        logoImageView.contentMode = .scaleToFill
        logoImageView.clipsToBounds = true
        logoImageView.layer.cornerRadius = 10
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupFriendsButton() {
        friendsButton = UIButton(type: .system)
        friendsButton.setImage(UIImage(systemName: "person.fill"), for: UIControl.State.normal)
        friendsButton.contentHorizontalAlignment = .fill
        friendsButton.contentVerticalAlignment = .fill
        friendsButton.imageView?.contentMode = .scaleAspectFit
        friendsButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupProfileButton() {
        profileButton = UIButton(type: .system)
        profileButton.setImage(UIImage(systemName: "person.circle.fill"), for: UIControl.State.normal)
        profileButton.contentHorizontalAlignment = .fill
        profileButton.contentVerticalAlignment = .fill
        profileButton.imageView?.contentMode = .scaleAspectFit
        profileButton.layer.cornerRadius = 25 // Circular button
        profileButton.layer.masksToBounds = true
        profileButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupRankingButton() {
        rankingButton = UIButton(type: .system)
        rankingButton.setTitle("Ranking", for: .normal)
        rankingButton.setTitleColor(.black, for: .normal)
        rankingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        rankingButton.contentHorizontalAlignment = .center
        rankingButton.contentVerticalAlignment = .center
        rankingButton.imageView?.contentMode = .scaleAspectFit
        rankingButton.backgroundColor = .rgb(255, 209, 17)

        rankingButton.layer.borderColor = UIColor.darkGray.cgColor
        rankingButton.layer.borderWidth = 2.0
        rankingButton.layer.cornerRadius = 10.0 // Rounded corners
        
        // Add menu to show in view
        rankingButton.showsMenuAsPrimaryAction = true
        rankingButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setUpExitButtonButton() {
        exitButton = UIButton(type: .system)
        exitButton.setTitle("Exit", for: .normal)
        exitButton.setTitleColor(.black, for: .normal)
        exitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        exitButton.contentHorizontalAlignment = .center
        exitButton.contentVerticalAlignment = .center

        exitButton.imageView?.contentMode = .scaleAspectFit
        exitButton.backgroundColor = .rgb(255, 209, 17)
        exitButton.layer.borderColor = UIColor.darkGray.cgColor
        exitButton.layer.borderWidth = 2.0
        exitButton.layer.cornerRadius = 10.0 // Rounded corners
        
        exitButton.showsMenuAsPrimaryAction = true
        exitButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupStartButton() {
        startButton = UIButton(type: .system)
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        startButton.contentHorizontalAlignment = .center
        startButton.contentVerticalAlignment = .center

        startButton.imageView?.contentMode = .scaleAspectFit
        startButton.backgroundColor = .rgb(255, 209, 17)
        startButton.layer.borderColor = UIColor.darkGray.cgColor
        startButton.layer.borderWidth = 2.0
        startButton.layer.cornerRadius = 10.0 // Rounded corners
        

        startButton.showsMenuAsPrimaryAction = true
        startButton.translatesAutoresizingMaskIntoConstraints = false
    }

    //MARK: initializing the constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            logoImageView.widthAnchor.constraint(equalToConstant: 50),
            logoImageView.heightAnchor.constraint(equalToConstant: 50),
            
            friendsButton.widthAnchor.constraint(equalToConstant: 50),
            friendsButton.heightAnchor.constraint(equalToConstant: 50),
            
            profileButton.widthAnchor.constraint(equalToConstant: 50),
            profileButton.heightAnchor.constraint(equalToConstant: 50),
            
            rankingButton.widthAnchor.constraint(equalToConstant: 200),
            rankingButton.heightAnchor.constraint(equalToConstant: 50),

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



