import UIKit
import FirebaseAuth

class HomePageViewController: UIViewController {
    let homePageView = HomePageView()
    var selectedProfileImage: UIImage?
    
    override func loadView() {
        view = homePageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the back button
        navigationItem.hidesBackButton = true
        
        //MARK: here
        if let profileImage = selectedProfileImage {
            homePageView.profileButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        // Setup button targets
        setupActions()
    }
    
    func setupActions() {
        // Add targets for all buttons
        homePageView.exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        homePageView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        homePageView.friendsButton.addTarget(self, action: #selector(friendsButtonTapped), for: .touchUpInside)
        homePageView.profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        homePageView.rankingButton.addTarget(self, action: #selector(rankingButtonTapped), for: .touchUpInside)
        // homePageView.merchandiseButton.addTarget(self, action: #selector(merchandiseButtonTapped), for: .touchUpInside)
    }
    
    @objc func exitButtonTapped() {
        // Handle logout
        do {
            try Auth.auth().signOut()
            // Clear UserDefaults
            UserDefaults.standard.removeObject(forKey: "sessionToken")
            // Navigate back to login screen
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
        // Add your game start logic here
        print("Start button tapped")
    }
        
    @objc func profileButtonTapped() {
        
        let displayUserProfileController = DisplayUserProfileController()
        navigationController?.pushViewController(displayUserProfileController, animated: true)
    }
    
    @objc func rankingButtonTapped() {
        // Navigate to ranking screen
        print("Ranking button tapped")
    }
    
    // @objc func merchandiseButtonTapped() {
    //     // Navigate to merchandise screen
    //     print("Merchandise button tapped")
    // }
}
