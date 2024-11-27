import UIKit

class RankingScreenView: UITableViewCell {

    
    var wrapperCellView: UIView!
    var profilePic: UIImageView!
    var labelName: UILabel!
    var labelRanking: UILabel!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.rgb(0,0,28)
        setupWrapperCellView()
        setupLabelName()
        setupProfilePic()
        setupLabelRanking()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UIView()
        wrapperCellView.backgroundColor = UIColor.rgb(0,0,28)
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.clipsToBounds = false
        contentView.addSubview(wrapperCellView)
    }
    
    func setupProfilePic(){
        profilePic = UIImageView()
        profilePic.image = UIImage(systemName: "person.circle")
        profilePic.contentMode = .scaleAspectFit
        profilePic.clipsToBounds = true
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(profilePic)
    }
    
    func setupLabelName(){
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 18)
        labelName.textColor = .systemYellow
        labelName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelName)
    }
    

    func setupLabelRanking(){
        labelRanking = UILabel()
        labelRanking.font = .systemFont(ofSize: 10)
        labelRanking.textColor = .systemYellow
        labelRanking.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelRanking)
    }
    
    func initConstraints() {
            NSLayoutConstraint.activate([
                wrapperCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                wrapperCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                wrapperCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                wrapperCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                
                profilePic.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
                profilePic.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
                profilePic.widthAnchor.constraint(equalToConstant: 40),
                profilePic.heightAnchor.constraint(equalToConstant: 40),
                
                labelName.leadingAnchor.constraint(equalTo: profilePic.trailingAnchor, constant: 16),
                labelName.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
                
                labelRanking.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
                labelRanking.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor)
            ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        wrapperCellView.layoutIfNeeded()
    }

}
