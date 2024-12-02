import UIKit

class RankingScreenView: UIView {
    
    var table: UITableView!
    var backButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .rgb(0, 0, 28)
        
        setupBackButton()
        setupTable()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackButton(){
        backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .white
        backButton.contentHorizontalAlignment = .left
        addSubview(backButton)
    }
    
    private func setupTable() {
        table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(RankingScreenViewCell.self, forCellReuseIdentifier: "RankingCell")
        table.separatorStyle = .none
        table.backgroundColor = .rgb(0, 0, 28)
        
        // Add some padding at the top for the navigation bar
        table.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        // scroll indicator insets to match content insets
        table.scrollIndicatorInsets = table.contentInset
        addSubview(table)
    }
    
    private func initConstraints(){
        NSLayoutConstraint.activate([
            
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),
            
            table.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 10),
            table.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            table.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            table.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}
