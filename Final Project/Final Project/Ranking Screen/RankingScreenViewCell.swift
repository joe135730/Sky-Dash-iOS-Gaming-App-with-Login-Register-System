import UIKit

class RankingScreenViewCell: UITableViewCell {

    var wrapperCellView: UIView!
    var profilePic: UIImageView!
    var labelName: UILabel!
    var labelRanking: UILabel!
    var labelScore: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.rgb(0, 0, 28)
        setupWrapperCellView()
        setupLabelName()
        setupProfilePic()
        setupLabelRanking()
        setupLabelScore()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //photo
    func configure(with ranking: RankingModel) {
        labelName.text = ranking.name
        labelScore.text = "\(ranking.score)"
        
        // Load profile photo if available
        if let photoURLString = ranking.profilePicURL,
           let photoURL = URL(string: photoURLString) {
            profilePic.loadRemoteImage(from: photoURL)
        } else {
            // Set default image if no photo URL
            profilePic.image = UIImage(systemName: "person.circle")?.withRenderingMode(.alwaysOriginal)
        }
    }
    
    struct Contact: Codable {
        let name: String
        let email: String
        let photoURL: String?
        let score: Int
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UIView()
        wrapperCellView.backgroundColor = UIColor.rgb(0, 0, 28)
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(wrapperCellView)
    }
    
    func setupProfilePic() {
        profilePic = UIImageView()
        profilePic.image = UIImage(systemName: "person.circle")?.withRenderingMode(.alwaysOriginal)
        profilePic.contentMode = .scaleAspectFit
        profilePic.clipsToBounds = true
        profilePic.layer.masksToBounds = true
        profilePic.layer.cornerRadius = 16.0
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(profilePic)
    }
    
    func setupLabelName() {
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 16)
        labelName.textColor = .systemYellow
        labelName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelName)
    }
    
    func setupLabelRanking() {
        labelRanking = UILabel()
        labelRanking.font = .systemFont(ofSize: 16)
        labelRanking.textColor = .systemYellow
        labelRanking.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelRanking)
    }
    
    func setupLabelScore() {
        labelScore = UILabel()
        labelScore.font = .systemFont(ofSize: 16)
        labelScore.textColor = .systemYellow
        labelScore.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelScore)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            labelRanking.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelRanking.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            
            profilePic.leadingAnchor.constraint(equalTo: labelRanking.trailingAnchor, constant: 8),
            profilePic.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            profilePic.widthAnchor.constraint(equalToConstant: 40),
            profilePic.heightAnchor.constraint(equalToConstant: 40),
            
            labelName.leadingAnchor.constraint(equalTo: profilePic.trailingAnchor, constant: 8),
            labelName.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            
            labelScore.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            labelScore.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor)
        ])
    }
}
