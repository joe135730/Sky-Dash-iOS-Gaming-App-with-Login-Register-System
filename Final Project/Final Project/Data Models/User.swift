import Foundation
import FirebaseFirestore

class UserToken{
    static var token: String = ""
}

struct Contact: Codable {
    @DocumentID var id: String?
    var name: String
    var email: String
    var lastMessage: String?
    var lastMessageTime: Date?
    var hasUnreadMessages: Bool?
    var score: Int
    var photoURL: String?
    
    init(name: String, email: String, score: Int = 0, phototURL: String? ) {
        self.name = name
        self.email = email
        self.score = score
        self.photoURL = phototURL
        self.hasUnreadMessages = false
    }
}

