import UIKit
import FirebaseFirestore
import FirebaseAuth

protocol FriendsTableViewControllerDelegate: AnyObject {
    func didSelectFriend(_ contact: Contact)
}

class FriendsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var friends: [Contact] = []
    weak var delegate: FriendsTableViewControllerDelegate?
    let db = Firestore.firestore()
    
    private let friendTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 28/255, alpha: 1.0)
        setupTableView()
        loadAllUsers()

        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

     @objc private func dismissView() {
        dismiss(animated: true)
    }
    
    private func setupTableView() {
        friendTableView.dataSource = self
        friendTableView.delegate = self
        friendTableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: "friendscell")
        friendTableView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 28/255, alpha: 1.0)

        friendTableView.separatorColor = .clear
        friendTableView.contentInset = .zero
        friendTableView.layoutMargins = .zero
        
        view.addSubview(friendTableView)
        friendTableView.frame = view.bounds
    }
    
    
    private func loadAllUsers() {
        guard let currentUserEmail = Auth.auth().currentUser?.email?.lowercased() else { return }
        
        db.collection("users").addSnapshotListener { [weak self] snapshot, error in
            if let error = error {
                print("Error loading users: \(error)")
                return
            }
            
            self?.db.collection("users")
                .document(currentUserEmail)
                .collection("contacts")
                .getDocuments { (contactsSnapshot, contactsError) in
                    if let contactsError = contactsError {
                        print("Error loading contacts: \(contactsError)")
                        return
                    }
                    let existingContactEmails = contactsSnapshot?.documents.compactMap { doc -> String? in
                        if let contact = try? doc.data(as: Contact.self) {
                            return contact.email.lowercased()
                        }
                        return nil
                    } ?? []
                    
                    self?.friends = snapshot?.documents.compactMap { document -> Contact? in
                        do {
                            let contact = try document.data(as: Contact.self)
                            let contactEmail = contact.email.lowercased()
                            
                            // Exclude current user and existing contacts
                            if contactEmail != currentUserEmail && !existingContactEmails.contains(contactEmail) {
                                return contact
                            }
                            return nil
                        } catch {
                            print("Error decoding contact: \(error)")
                            return nil
                        }
                    } ?? []
                    
                    DispatchQueue.main.async {
                        self?.friendTableView.reloadData()
                    }
                }
        }
    }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendscell", for: indexPath) as! FriendsTableViewCell
        let friend = friends[indexPath.row]
        cell.configure(with: friend)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFriend = friends[indexPath.row]
        dismiss(animated: true) { [weak self] in
            self?.delegate?.didSelectFriend(selectedFriend)
        }
    }
}
