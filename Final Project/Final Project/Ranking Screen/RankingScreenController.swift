import UIKit

class RankingScreenController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView!
    var rankingData: [RankingModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Ranking"
        self.view.backgroundColor = .rgb(0, 0, 28)
        
        setupTableView()
        fetchRankingData() // Load ranking data
    }

    func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RankingScreenView.self, forCellReuseIdentifier: "RankingCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .rgb(0, 0, 28)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        self.view.addSubview(tableView)
        

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    // Fetch data for the rankings
    func fetchRankingData() {
        // Simulating ranking data; replace with your real data source
        rankingData = [
            RankingModel(profilePic: UIImage(systemName: "person.circle")!, name: "Alice", ranking: "#1"),
        ]
        tableView.reloadData()
    }

    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankingCell", for: indexPath) as! RankingScreenView
        let ranking = rankingData[indexPath.row]
        
        cell.labelName.text = ranking.name
        cell.labelRanking.text = ranking.ranking
        cell.profilePic.image = ranking.profilePic
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let ranking = rankingData[indexPath.row]
        
        // Example action: show an alert with the selected ranking
        let alert = UIAlertController(title: "Selected Ranking", message: "\(ranking.name) is ranked \(ranking.ranking)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
