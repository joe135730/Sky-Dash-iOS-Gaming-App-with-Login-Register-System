import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

extension RankingScreenController{
    
    func addNewScore(name:String, score: Int){
        let userEmail = Auth.auth().currentUser?.email ?? ""
        let userRef = db.collection("users").document(userEmail).collection("ranking")
        
        let newScoreData: [String: Any] = [
            "name": name,
            "score": score,
            "ranking": "",
        ]

        userRef.addDocument(data: newScoreData) { error in
            if let error = error {
                print("Error adding new score: \(error.localizedDescription)")
            } else {
                print("New Score added successfully for \(score).")
            }
        }
    }
    
    func updatePlayerScore(email: String, newScore: Int) {
        let userRef = db.collection("users").document(email).collection("ranking")
        
        userRef.document("documentID").updateData([
            "score": newScore
        ]) { error in
            if let error = error {
                print("Error updating score: \(error.localizedDescription)")
            } else {
                print("Score updated successfully for \(newScore).")
            }
        }
    }
    
    func updatePlayerRanking(email: String, newRanking: Int){
        let userEmail = Auth.auth().currentUser?.email ?? ""
        updatePlayerScore(email: userEmail, newScore: newRanking)
    }

    func fetchAndDisplayRankings(completion: @escaping ([RankingModel]) -> Void) {
        guard let userEmail = Auth.auth().currentUser?.email else {
            print("Error: User not logged in.")
            completion([])
            return
        }

        db.collection("users").document(userEmail).collection("ranking")
            .order(by: "score", descending: true)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching rankings: \(error.localizedDescription)")
                    completion([])
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents found.")
                    completion([])
                    return
                }
                
                var rankings: [RankingModel] = documents.compactMap { document in
                    let data = document.data()
                    guard let name = data["name"] as? String,
                          let ranking  = data["ranking"] as? String,
                          let score = data["score"] as? Int else {
                        return nil
                    }
                    
                    return RankingModel(
                        profilePic: UIImage(systemName: "person.circle") ?? UIImage(),
                        name: name,
                        ranking: "",
                        score: score
                    )
                }
                
                // Assign rankings
                for (index, ranking) in rankings.enumerated() {
                    rankings[index].ranking = "#\(index + 1)"
                }
                
                completion(rankings)
            }
    }
    
    func uploadImage(_ image: UIImage, completion: @escaping (String?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(nil)
            return
        }
        
        let storageRef = Storage.storage().reference().child("profile_pics/\(UUID().uuidString).jpg")
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Error fetching download URL: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                completion(url?.absoluteString)
            }
        }
    }
}
