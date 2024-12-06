import UIKit
import FirebaseAuth

class HomePageViewController: UIViewController {
    let homePageView = HomePageView()
    var selectedProfileImage: UIImage?
    var currentUser:FirebaseAuth.User?
    
    override func loadView() {
        view = homePageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        //MARK: here
        if let profileImage = selectedProfileImage {
            homePageView.profileButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }

        setupActions()

        homePageView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    func setupActions() {

        homePageView.exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        homePageView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        homePageView.friendsButton.addTarget(self, action: #selector(friendsButtonTapped), for: .touchUpInside)
        homePageView.profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        homePageView.rankingButton.addTarget(self, action: #selector(rankingButtonTapped), for: .touchUpInside)
    }
    
    @objc func exitButtonTapped() {
        // Handle logout
        do {
            try Auth.auth().signOut()

            UserDefaults.standard.removeObject(forKey: "sessionToken")
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    @objc func friendsButtonTapped() {
        let mainScreenController = MainScreenController()
        navigationController?.pushViewController(mainScreenController, animated: true)
    }
    
    @objc func startButtonTapped() {
        print("Start button tapped")
        let gameScreenController = GameScreenController()
        
        navigationController?.pushViewController(gameScreenController, animated: true)
    }
        
    @objc func profileButtonTapped() {
        
        let displayUserProfileController = DisplayUserProfileController()
        navigationController?.pushViewController(displayUserProfileController, animated: true)
    }
    
    @objc func rankingButtonTapped() {
        let rankingScreenController = RankingScreenController()
        navigationController?.pushViewController(rankingScreenController, animated: true)
    }
    

}
