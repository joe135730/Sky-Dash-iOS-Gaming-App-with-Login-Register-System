import UIKit
import FirebaseFirestore

struct RankingModel {
    var profilePicURL: String?
    var name: String
    var ranking: String
    var score: Int
    
    init(profilePicURL: String? = nil, name: String, ranking: String, score: Int){
        self.profilePicURL = profilePicURL
        self.name = name
        self.ranking = ranking
        self.score = score
    }
    
    init?(document: [String: Any]) {
        guard let name = document["name"] as? String,
              let score = document["score"] as? Int else {
            return nil
        }
        
        self.profilePicURL = document["profilePicURL"] as? String
        self.name = name
        self.ranking = document["ranking"] as? String ?? ""
        self.score = score
    }
    
    func toDictionary() -> [String: Any] {
       return [
           "profilePicURL": profilePicURL ?? "",
           "name": name,
           "ranking": ranking,
           "score": score
       ]
   }
}
