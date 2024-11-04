import UIKit

class UserProfileView: UIView {
    
    var titleLabel: UILabel!
    var playerInfoView: UIView!
    var coinsLabel: UILabel!
    var purchasedItemsLabel: UILabel!
    var editProfileButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        setupTitleLabel()
        setupPlayerInfoView()
        setupCoinsLabel()
        setupPurchasedItemsLabel()
        setupEditProfileButton()
        
        initConstraints()
    }
    
    func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "User Profile"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .yellow
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
    }
    
    func setupPlayerInfoView() {
        playerInfoView = UIView()
        playerInfoView.backgroundColor = .yellow
        playerInfoView.layer.cornerRadius = 10
        playerInfoView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(playerInfoView)
        
        let playerNameLabel = UILabel()
        playerNameLabel.text = "Player Name: John"
        playerNameLabel.textColor = .black
        playerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let usernameLabel = UILabel()
        usernameLabel.text = "Username: jd123"
        usernameLabel.textColor = .black
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let passwordLabel = UILabel()
        passwordLabel.text = "Password: Sd@001"
        passwordLabel.textColor = .black
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        playerInfoView.addSubview(playerNameLabel)
        playerInfoView.addSubview(usernameLabel)
        playerInfoView.addSubview(passwordLabel)
        
        NSLayoutConstraint.activate([
            playerNameLabel.topAnchor.constraint(equalTo: playerInfoView.topAnchor, constant: 10),
            playerNameLabel.leadingAnchor.constraint(equalTo: playerInfoView.leadingAnchor, constant: 10),
            
            usernameLabel.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor, constant: 10),
            usernameLabel.leadingAnchor.constraint(equalTo: playerNameLabel.leadingAnchor),
            
            passwordLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10),
            passwordLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            passwordLabel.bottomAnchor.constraint(equalTo: playerInfoView.bottomAnchor, constant: -10)
        ])
    }
    
    func setupCoinsLabel() {
        coinsLabel = UILabel()
        coinsLabel.text = "Coins Earned: 20 pt"
        coinsLabel.textColor = .black
        coinsLabel.backgroundColor = .yellow
        coinsLabel.layer.cornerRadius = 10
        coinsLabel.clipsToBounds = true
        coinsLabel.textAlignment = .center
        coinsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(coinsLabel)
    }
    
    func setupPurchasedItemsLabel() {
        purchasedItemsLabel = UILabel()
        purchasedItemsLabel.text = "Purchased Items:\n - Shield potion x3\n - Health Boost potion x2"
        purchasedItemsLabel.textColor = .black
        purchasedItemsLabel.backgroundColor = .yellow
        purchasedItemsLabel.layer.cornerRadius = 10
        purchasedItemsLabel.clipsToBounds = true
        purchasedItemsLabel.numberOfLines = 0
        purchasedItemsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(purchasedItemsLabel)
    }
    
    func setupEditProfileButton() {
        editProfileButton = UIButton(type: .system)
        editProfileButton.setTitle("Edit Profile", for: .normal)
        editProfileButton.backgroundColor = .blue
        editProfileButton.setTitleColor(.white, for: .normal)
        editProfileButton.layer.cornerRadius = 5
        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(editProfileButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Title at the top
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            // Player info view
            playerInfoView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            playerInfoView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            playerInfoView.widthAnchor.constraint(equalToConstant: 180),
            playerInfoView.heightAnchor.constraint(equalToConstant: 200),
            
            // Coins label on the right
            coinsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            coinsLabel.leadingAnchor.constraint(equalTo: playerInfoView.trailingAnchor, constant: 20),
            coinsLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            coinsLabel.heightAnchor.constraint(equalToConstant: 50),
            
            // Purchased items label below coins label
            purchasedItemsLabel.topAnchor.constraint(equalTo: coinsLabel.bottomAnchor, constant: 10),
            purchasedItemsLabel.leadingAnchor.constraint(equalTo: coinsLabel.leadingAnchor),
            purchasedItemsLabel.trailingAnchor.constraint(equalTo: coinsLabel.trailingAnchor),
            purchasedItemsLabel.heightAnchor.constraint(equalToConstant: 190), // Increased height
            
            // Edit Profile button below player info view, matching width
            editProfileButton.topAnchor.constraint(equalTo: playerInfoView.bottomAnchor, constant: 10),
            editProfileButton.leadingAnchor.constraint(equalTo: playerInfoView.leadingAnchor),
            editProfileButton.trailingAnchor.constraint(equalTo: playerInfoView.trailingAnchor),
            editProfileButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
