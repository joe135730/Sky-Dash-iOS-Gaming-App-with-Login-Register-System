import UIKit

class RankingView: UIView {
    
    var titleLabel: UILabel!
    var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        setupTitleLabel()
        setupStackView()
        
        initConstraints()
        
        // Adding sample rankings
        addRanking(name: "John", rank: "1st", isSelf: false)
        addRanking(name: "Mary", rank: "2nd", isSelf: false)
        addRanking(name: "Self", rank: "10rd", isSelf: true) // Highlighted as "Self"
    }
    
    func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Ranking"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .yellow
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
    }
    
    func setupStackView() {
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
    }
    
    func addRanking(name: String, rank: String, isSelf: Bool) {
        let rankingItemView = UIView()
        rankingItemView.layer.cornerRadius = 10
        rankingItemView.backgroundColor = isSelf ? .red : .yellow
        rankingItemView.translatesAutoresizingMaskIntoConstraints = false
        
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: "person.circle.fill")
        iconImageView.tintColor = isSelf ? .white : .blue
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.textColor = isSelf ? .white : .black
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let rankLabel = UILabel()
        rankLabel.text = rank
        rankLabel.textColor = isSelf ? .white : .black
        rankLabel.font = UIFont.boldSystemFont(ofSize: 18)
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        
        rankingItemView.addSubview(iconImageView)
        rankingItemView.addSubview(nameLabel)
        rankingItemView.addSubview(rankLabel)
        
        // Add constraints for each component within the ranking item
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: rankingItemView.centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: rankingItemView.leadingAnchor, constant: 10),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            
            nameLabel.centerYAnchor.constraint(equalTo: rankingItemView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            
            rankLabel.centerYAnchor.constraint(equalTo: rankingItemView.centerYAnchor),
            rankLabel.trailingAnchor.constraint(equalTo: rankingItemView.trailingAnchor, constant: -10)
        ])
        
        // Add the ranking item view to the stack view
        stackView.addArrangedSubview(rankingItemView)
        
        // Set the height constraint for the ranking item
        NSLayoutConstraint.activate([
            rankingItemView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
