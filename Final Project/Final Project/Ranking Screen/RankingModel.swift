import UIKit
import FirebaseFirestore

struct RankingModel {
    var profilePic: UIImage
    var name: String
    var ranking: String
    var score: Int
    
    init(profilePic: UIImage, name: String, ranking: String, score: Int){
        self.profilePic = profilePic
        self.name = name
        self.ranking = ranking
        self.score = score
    }
    
    init?(document: [String: Any]) {
        guard let profilePic = document["profilePic"] as? String,
              let name = document["name"] as? String,
              let score = document["score"] as? Int else {
            return nil
        }
        self.profilePic = UIImage(systemName: "person.circle") ?? UIImage()
        self.name = name
        self.ranking = ""
        self.score = score
    }
    
    func toDictionary() -> [String: Any] {
        let imageUrlString = ""
           return [
               "profilePic": "",
               "name": name,
               "score": score
           ]
       }
}
