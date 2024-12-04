import UIKit
import FirebaseFirestore
import FirebaseAuth

class GameScreenController: UIViewController {
    let gameScreenView = GameScreenView()
    
    private var gameTimer: Timer?
    private var obstacleTimer: Timer?
    private var shootingTimer: Timer?
    private var score = 0
    private var isDragging = false
    private var lastTouchY: CGFloat = 0
    
    override func loadView() {
        view = gameScreenView
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeLeft
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupGame()
    }
    
    private func setupGame() {
        // Replace the tap gesture with pan gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(panGesture)
        
        startGame()
    }
    
    private func startGame() {
        score = 0
        gameScreenView.resetGame()  // Reset game state
        
        // Start game loop
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { [weak self] _ in
            self?.updateGame()
        }
        
        // Increase spawn rate by reducing the interval (e.g., from 2.0 to 1.0 seconds)
        obstacleTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.gameScreenView.addObstacle()
        }
        
        // Start automatic shooting
        shootingTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.gameScreenView.shootBullet()
        }
    }
    
    private func updateGame() {
        if let rocket = gameScreenView.rocket {
            // Keep rocket within bounds
            let maxY = view.bounds.height - rocket.frame.height/2
            let minY = rocket.frame.height/2
            
            let currentY = rocket.center.y
            let clampedY = min(max(currentY, minY), maxY)
            gameScreenView.moveRocket(to: clampedY)
            
            // Check for collisions
            let (rocketHit, hitMonsters) = gameScreenView.checkCollisions()
            
            if rocketHit {
                endGame()
                return
            }
            
            // Only handle monster hits if game is still running
            for monster in hitMonsters {
                // Check if it's a blueMushroom by size
                if monster.frame.width > 60 { // blueMushroom is 1.5x size
                    score += 5 // 5 points for blueMushroom
                } else {
                    score += 1 // 1 point for normal monsters
                }
                gameScreenView.removeObstacle(monster) // Remove monster only when hit by bullet
                gameScreenView.updateScore(score)
            }
        }
    }
    
    private func endGame() {
        // Stop all timers
        gameTimer?.invalidate()
        obstacleTimer?.invalidate()
        shootingTimer?.invalidate()
        
        // Stop all ongoing animations
        gameScreenView.stopAllAnimations()
        
        //MARK: modify here
        let rankingData = RankingModel(
            profilePic: UIImage(systemName: "person.circle") ?? UIImage(),
            name: Auth.auth().currentUser?.displayName ?? Auth.auth().currentUser?.email ?? "",
            ranking: "",
            score: score
        )
        
        // save the score
        if let rankingScreen = navigationController?.viewControllers.first(where: { $0 is RankingScreenController }) as? RankingScreenController {
            rankingScreen.saveRankingToFirestore(rankingData: rankingData)
        }
        
        updatePlayerScore(newScore: score) { success in
            if success {
                print("Score successfully updated")
            }
        }
        
        let alert = UIAlertController(title: "Game Over",
                                    message: "Score: \(score)",
                                    preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.startGame()
        })
        
        alert.addAction(UIAlertAction(title: "Main Menu", style: .cancel) { [weak self] _ in
            guard let self = self else { return }
                    
            // Navigate to Ranking Screen
            if let rankingScreen = self.navigationController?.viewControllers.first(where: { $0 is RankingScreenController }) as? RankingScreenController {
                rankingScreen.observeRankings() 
            }
            
            self.navigationController?.popViewController(animated: true)
        })
        
        present(alert, animated: true)
    }
    
    //MARK: update player score
    private func updatePlayerScore(newScore: Int, completion: @escaping ( Bool) -> Void){
        let db = Firestore.firestore()
        guard let userEmail = Auth.auth().currentUser?.email else {
            completion(false)
            return
        }
        
        let userName = Auth.auth().currentUser?.displayName ?? userEmail
        
        let rankingRef = db.collection("users")
            .document(userEmail)
            .collection("ranking")
            .document()
        
        rankingRef.getDocument{ (snapshot, error) in
            if let document = snapshot, document.exists{
                let currentScore = document.data()?["score"] as? Int ?? 0
                print("current score:\(currentScore)")
                
                if newScore > currentScore {
                    rankingRef.updateData([
                        "name": userName,
                        "score": newScore,
                        "profilePic": "",
                        "timestamp": FieldValue.serverTimestamp()
                    ]) {error in
                        if let error = error{
                            print("Error updating score:\(error.localizedDescription)")
                            completion(false)
                        }
                        else{
                            print("New score updated.")
                            completion(true)
                        }
                    }
                } else {
                    print("Score not updated: Current score is higher")
                    completion(false)
                }
            } else {
                // If document doesn't exist, create it
                rankingRef.setData([
                    "name": userName,
                    "score": newScore,
                    "profilePic": "",
                    "timestamp": FieldValue.serverTimestamp()
               ]) { error in
                   if let error = error {
                       print("Error creating score:\(error.localizedDescription)")
                       completion(false)
                   } else {
                       print("New score created.")
                       completion(true)
                   }
               }
            }
            
        }
        
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let rocket = gameScreenView.rocket else { return }
        
        switch gesture.state {
        case .began:
            isDragging = true
            lastTouchY = gesture.location(in: view).y
            
        case .changed:
            let currentTouchY = gesture.location(in: view).y
            let deltaY = currentTouchY - lastTouchY
            
            // Move rocket based on touch movement
            let newY = rocket.center.y + deltaY
            gameScreenView.moveRocket(to: newY)
            
            lastTouchY = currentTouchY
            
        case .ended, .cancelled:
            isDragging = false
            
        default:
            break
        }
    }
}
