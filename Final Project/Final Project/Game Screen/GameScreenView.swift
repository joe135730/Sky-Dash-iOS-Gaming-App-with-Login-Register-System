import UIKit

class GameScreenView: UIView {
    // MARK: - Game Elements
    var rocket: UIImageView?
    var scoreLabel: UILabel!
    var obstacles: [UIImageView] = []
    var bullets: [UIView] = []
    
    // Add property to track monster health
    private var monsterHealth: [UIImageView: Int] = [:]
    
    // Update monster types with weights (normal monsters more common)
    private let monsterTypes = ["ribbonPig", "slime", "mushroom", "blueMushroom"]
    private let monsterWeights = [0.3, 0.3, 0.3, 0.1] // 10% chance for blueMushroom
    
    // Add this property to track game state
    private var isGameOver = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGame() {
        self.backgroundColor = .black
        
        // Setup score label first
        scoreLabel = UILabel()
        scoreLabel.textColor = .white
        scoreLabel.font = .systemFont(ofSize: 24, weight: .bold)
        scoreLabel.text = "Score: 0"
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scoreLabel)
        
        // Setup rocket in the middle
        let rocketSize: CGFloat = 60
        let safeTopMargin: CGFloat = 60 // Space for score label
        rocket = UIImageView(frame: CGRect(
            x: 100,
            y: (bounds.height - rocketSize) / 2, // Center vertically
            width: rocketSize,
            height: rocketSize
        ))
        rocket?.image = UIImage(named: "rocket")
        rocket?.contentMode = .scaleAspectFit
        if let rocket = rocket {
            addSubview(rocket)
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            scoreLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    // MARK: - Game Methods
    func moveRocket(to yPosition: CGFloat) {
        let safeTopMargin: CGFloat = 80 // Space for score label
        let rocketSize: CGFloat = rocket?.frame.height ?? 60
        
        // Clamp the position to avoid score area
        let clampedY = max(safeTopMargin, yPosition)
        rocket?.center.y = clampedY
    }
    
    func addObstacle() {
        let obstacleSize: CGFloat = 60
        let safeTopMargin: CGFloat = 60 // Space for score label
        
        // Random monster selection with weights
        let randomValue = Double.random(in: 0...1)
        var cumulativeWeight = 0.0
        var selectedMonster = monsterTypes[0]
        
        for (index, weight) in monsterWeights.enumerated() {
            cumulativeWeight += weight
            if randomValue <= cumulativeWeight {
                selectedMonster = monsterTypes[index]
                break
            }
        }
        
        // Adjust spawn position to avoid score area
        let yPosition = CGFloat.random(in: safeTopMargin...(bounds.height - obstacleSize))
        
        // Adjust size for blueMushroom
        let actualSize = selectedMonster == "blueMushroom" ? obstacleSize * 1.5 : obstacleSize
        
        let obstacle = UIImageView(frame: CGRect(x: bounds.width,
                                               y: yPosition,
                                               width: actualSize,
                                               height: actualSize))
        obstacle.image = UIImage(named: selectedMonster)
        obstacle.contentMode = .scaleAspectFit
        addSubview(obstacle)
        obstacles.append(obstacle)
        
        // Set initial health for blueMushroom
        if selectedMonster == "blueMushroom" {
            monsterHealth[obstacle] = 2
        }
        
        UIView.animate(withDuration: 3.0, delay: 0, options: [.curveLinear]) {
            obstacle.frame.origin.x = -actualSize
        } completion: { [weak self] finished in
            // Only remove if game is not over and animation completed normally
            if finished && !self!.isGameOver && self?.obstacles.contains(obstacle) == true {
                self?.monsterHealth.removeValue(forKey: obstacle)
                obstacle.removeFromSuperview()
                self?.obstacles.removeAll { $0 == obstacle }
            }
        }
    }
    
    func shootBullet() {
        guard let rocket = rocket else { return }
        
        let bulletSize: CGFloat = 10
        let bullet = UIView(frame: CGRect(x: rocket.frame.maxX,
                                        y: rocket.center.y,
                                        width: bulletSize,
                                        height: bulletSize))
        bullet.backgroundColor = .yellow
        bullet.layer.cornerRadius = bulletSize / 2
        addSubview(bullet)
        bullets.append(bullet)
        
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveLinear]) {
            bullet.frame.origin.x = self.bounds.width + bulletSize
        } completion: { [weak self] finished in
            if finished && self?.bullets.contains(bullet) == true && bullet.layer.speed != 0 {
                bullet.removeFromSuperview()
                self?.bullets.removeAll { $0 == bullet }
            }
        }
    }
    
    func updateScore(_ newScore: Int) {
        scoreLabel.text = "Score: \(newScore)"
    }
    
    func checkCollisions() -> (rocketHit: Bool, monsterHit: [UIImageView]) {
        guard let rocketFrame = rocket?.frame else { return (false, []) }
        
        // Create a smaller hit box for the rocket (reduce the size by 40%)
        let smallerRocketFrame = CGRect(
            x: rocketFrame.midX - rocketFrame.width * 0.3,  // 30% of original width
            y: rocketFrame.midY - rocketFrame.height * 0.3, // 30% of original height
            width: rocketFrame.width * 0.6,  // 60% of original width
            height: rocketFrame.height * 0.6  // 60% of original height
        )
        
        // Check if rocket hits any obstacle
        for obstacle in obstacles {
            let actualFrame = obstacle.layer.presentation()?.frame ?? obstacle.frame
            // Create a smaller hit box for the obstacle too
            let smallerObstacleFrame = CGRect(
                x: actualFrame.midX - actualFrame.width * 0.4,
                y: actualFrame.midY - actualFrame.height * 0.4,
                width: actualFrame.width * 0.8,
                height: actualFrame.height * 0.8
            )
            
            if smallerRocketFrame.intersects(smallerObstacleFrame) {
                // Don't return the hit monster in the array since we don't want to remove it
                return (true, [])
            }
        }
        
        // Check if bullets hit any obstacle
        var hitMonsters: [UIImageView] = []
        var bulletsToRemove: [UIView] = []
        
        for bullet in bullets {
            let actualBulletFrame = bullet.layer.presentation()?.frame ?? bullet.frame
            
            for obstacle in obstacles where !hitMonsters.contains(obstacle) {
                let actualObstacleFrame = obstacle.layer.presentation()?.frame ?? obstacle.frame
                let expandedObstacleFrame = actualObstacleFrame.insetBy(dx: 0, dy: 0)
                
                if actualBulletFrame.intersects(expandedObstacleFrame) {
                    // Handle blueMushroom hits
                    if let health = monsterHealth[obstacle] {
                        // It's a blueMushroom
                        monsterHealth[obstacle] = health - 1
                        if health <= 1 {
                            // blueMushroom defeated
                            hitMonsters.append(obstacle)
                            monsterHealth.removeValue(forKey: obstacle)
                        }
                    } else {
                        // Normal monster
                        hitMonsters.append(obstacle)
                    }
                    
                    bulletsToRemove.append(bullet)
                    break
                }
            }
        }
        
        // Remove hit bullets
        for bullet in bulletsToRemove {
            bullet.removeFromSuperview()
            bullets.removeAll { $0 == bullet }
        }
        
        return (false, hitMonsters)
    }
    
    func removeObstacle(_ obstacle: UIImageView) {
        obstacle.removeFromSuperview()
        obstacles.removeAll { $0 == obstacle }
    }
    

    
    // Add this new method
    func stopAllAnimations() {
        isGameOver = true  // Set game state
        
        // Pause all obstacle animations by setting their speed to 0
        for obstacle in obstacles {
            obstacle.layer.speed = 0
            obstacle.layer.timeOffset = obstacle.layer.convertTime(CACurrentMediaTime(), from: nil)
        }
        
        // Pause all bullet animations
        for bullet in bullets {
            bullet.layer.speed = 0
            bullet.layer.timeOffset = bullet.layer.convertTime(CACurrentMediaTime(), from: nil)
        }
        
        // Remove any bullets that are still on screen
        bullets.forEach { $0.removeFromSuperview() }
        bullets.removeAll()
    }
    
    // Add this method to reset game state
    func resetGame() {
        isGameOver = false
    }
}
