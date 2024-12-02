import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class RankingScreenController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var rankingView: RankingScreenView!
    var rankingData: [RankingModel] = []
    let db = Firestore.firestore()

    override func loadView() {
        rankingView = RankingScreenView()
        view = rankingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Ranking"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        rankingView.table.delegate = self
        rankingView.table.dataSource = self
        
        rankingView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        observeRankings()
        print("observe success")
    }
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    func saveRankingToFirestore(rankingData: RankingModel) {
        guard let userEmail = Auth.auth().currentUser?.email else{
            print("Error: User not logged in.")
            return
        }
        
        let rankingCollection = db.collection("users")
            .document(userEmail)
            .collection("ranking")
            .document()
     
        rankingCollection.setData([
            "name": rankingData.name,
            "score": rankingData.score,
            "profilePic": ""
        ]) { error in
            if let error = error {
                print("Error saving ranking: \(error.localizedDescription)")
            } else {
                print("Ranking saved successfully")
            }
        }

    }
    
    //MARK: observe all user's ranking
    func observeRankings() {
        guard let currentUserEmail = Auth.auth().currentUser?.email else {
            print("Error: User not logged in.")
            return
        }
        
        let rankingObserve = db.collectionGroup("ranking")
            .order(by: "score", descending: true)
            .addSnapshotListener { [weak self] querySnapshot, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error observing rankings: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else { return }
                
                DispatchQueue.global(qos: .userInitiated).async {
                    // Create a dictionary to store best score per user
                    var userBestScores: [String: (score: Int, name: String, imageUrl: String)] = [:]
                    
                    // Process all documents to get best score per user
                    for document in documents {
                        let data = document.data()
                        guard let name = data["name"] as? String,
                              let score = data["score"] as? Int,
                              let imageUrl = data["profilePic"] as? String,
                              let userEmail = document.reference.parent.parent?.documentID else { continue }
                        
                        if let existing = userBestScores[userEmail] {
                            if score > existing.score {
                                userBestScores[userEmail] = (score, name, imageUrl)
                            }
                        } else {
                            userBestScores[userEmail] = (score, name, imageUrl)
                        }
                    }
                    
                    // Convert dictionary to array and sort by score
                    let newRankingData = userBestScores.values
                        .sorted { $0.score > $1.score }
                        .enumerated()
                        .map { (index, userData) -> RankingModel in
                            var profileImage = UIImage(systemName: "person.circle") ?? UIImage()
                            if let url = URL(string: userData.imageUrl),
                               let data = try? Data(contentsOf: url) {
                                profileImage = UIImage(data: data) ?? profileImage
                            }
                            
                            return RankingModel(
                                profilePic: profileImage,
                                name: userData.name,
                                ranking: "#\(index + 1)",
                                score: userData.score
                            )
                        }
                    
                    DispatchQueue.main.async {
                        self.rankingData = newRankingData
                        print("show new ranking data: \(newRankingData)")
                        self.rankingView.table.reloadData()
                        print("show Reload")
                    }
                }
            }
    }

    func observeOwnScore() {
        guard let userEmail = Auth.auth().currentUser?.email else {
            print("Error: User not logged in.")
            return
        }
        
        let rankingObserve = db.collection("users")
            .document(userEmail)
            .collection("ranking")
            .order(by: "score", descending: true)
            .addSnapshotListener { [weak self] querySnapshot, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error observing rankings: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else { return }
                
                DispatchQueue.global(qos: .userInitiated).async {
                    let newRankingData = documents.enumerated().compactMap { (index, document) -> RankingModel? in
                        let data = document.data()
                        guard let name = data["name"] as? String,
                              let score = data["score"] as? Int,
                              let imageUrl = data["profilePic"] as? String else { return nil }
                        
                        var profileImage = UIImage(systemName: "person.circle") ?? UIImage()
                        if let url = URL(string: imageUrl),let data = try? Data(contentsOf: url) {
                            profileImage = UIImage(data: data) ?? profileImage
                        }
                        return RankingModel(
                            profilePic: profileImage,
                            name: name,
                            ranking: "#\(index + 1)",
                            score: score
                        )
                    }
                    
                    DispatchQueue.main.async {
                        self.rankingData = newRankingData
                        print("show new ranking data: \(newRankingData)")
                        self.rankingView.table.reloadData()
                        print("show Reload")
                    }
                }
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if rankingData.isEmpty {
            let label = UILabel()
            label.text = "No rankings available."
            label.textAlignment = .center
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            tableView.backgroundView = label
            tableView.separatorStyle = .none
        } else {
            tableView.backgroundView = nil
        }
        return rankingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankingCell", for: indexPath) as! RankingScreenViewCell
        let ranking = rankingData[indexPath.row]
        cell.labelName.text = ranking.name
        cell.labelRanking.text = ranking.ranking
        cell.labelScore.text = "\(ranking.score)"
        cell.profilePic.image = ranking.profilePic
        
        print("Displaying cell for: \(ranking.name), \(ranking.ranking), \(ranking.score)")
        return cell
    }
}
