//
//  GameManager.swift
//  ARViewer
//
//  Manages game state, collision handling, and entity spawning
//

import SceneKit
import ARKit

/// Delegate protocol for game events that need UI updates
protocol GameManagerDelegate: AnyObject {
    func gameManager(_ manager: GameManager, didUpdateScore score: Int)
}

/// Manages game logic, collision handling, and entity spawning
final class GameManager: NSObject {

    // MARK: - Constants

    private enum Constants {
        static let shipRemovalDelay: TimeInterval = 0.5
        static let spawnRangeMin: Float = -0.5
        static let spawnRangeMax: Float = 0.5
        static let spawnDepth: Float = -1.0
    }

    // MARK: - Properties

    weak var delegate: GameManagerDelegate?
    private weak var sceneView: ARSCNView?
    private let soundManager: SoundManager

    private(set) var score: Int = 0 {
        didSet {
            delegate?.gameManager(self, didUpdateScore: score)
        }
    }

    // MARK: - Initialization

    init(sceneView: ARSCNView, soundManager: SoundManager = .shared) {
        self.sceneView = sceneView
        self.soundManager = soundManager
        super.init()
    }

    // MARK: - Public API

    /// Resets the game state
    func reset() {
        score = 0
    }

    /// Fires a bullet from the camera position in the direction the camera is facing
    func fireBullet() {
        guard let sceneView = sceneView else { return }

        soundManager.play(.torpedo)

        let bullet = Bullet()
        let (direction, position) = getUserVector()

        bullet.position = position
        bullet.physicsBody?.applyForce(direction, asImpulse: true)
        sceneView.scene.rootNode.addChildNode(bullet)
    }

    /// Adds a new ship at a random position in front of the user
    func addNewShip() {
        guard let sceneView = sceneView else { return }

        let ship = Ship()
        let posX = randomFloat(in: Constants.spawnRangeMin...Constants.spawnRangeMax)
        let posY = randomFloat(in: Constants.spawnRangeMin...Constants.spawnRangeMax)

        ship.position = SCNVector3(posX, posY, Constants.spawnDepth)
        sceneView.scene.rootNode.addChildNode(ship)
    }

    // MARK: - Collision Handling

    /// Handles physics contact between nodes
    /// - Parameter contact: The physics contact information
    func handleContact(_ contact: SCNPhysicsContact) {
        guard isShipBulletCollision(contact) else { return }

        print("Hit ship!")

        // Remove bullet immediately
        removeNode(contact.nodeB, withExplosion: false)
        score += 1

        // Remove ship with explosion after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.shipRemovalDelay) { [weak self] in
            self?.removeNode(contact.nodeA, withExplosion: true)
            self?.addNewShip()
        }
    }

    // MARK: - Private Methods

    private func isShipBulletCollision(_ contact: SCNPhysicsContact) -> Bool {
        let nodeAIsShip = contact.nodeA.physicsBody?.categoryBitMask == CollisionCategory.ship.rawValue
        let nodeBIsShip = contact.nodeB.physicsBody?.categoryBitMask == CollisionCategory.ship.rawValue
        return nodeAIsShip || nodeBIsShip
    }

    private func removeNode(_ node: SCNNode, withExplosion: Bool) {
        soundManager.play(.collision)

        if withExplosion {
            addExplosionEffect(at: node.position)
            soundManager.play(.explosion)
        }

        node.removeFromParentNode()
    }

    private func addExplosionEffect(at position: SCNVector3) {
        guard let sceneView = sceneView,
              let particleSystem = SCNParticleSystem(named: "explosion", inDirectory: nil) else {
            return
        }

        let systemNode = SCNNode()
        systemNode.addParticleSystem(particleSystem)
        systemNode.position = position
        sceneView.scene.rootNode.addChildNode(systemNode)
    }

    private func getUserVector() -> (direction: SCNVector3, position: SCNVector3) {
        guard let frame = sceneView?.session.currentFrame else {
            return (SCNVector3(0, 0, -1), SCNVector3(0, 0, -0.2))
        }

        let transform = SCNMatrix4(frame.camera.transform)
        let direction = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        let position = SCNVector3(transform.m41, transform.m42, transform.m43)

        return (direction, position)
    }

    private func randomFloat(in range: ClosedRange<Float>) -> Float {
        let random = Float(arc4random()) / Float(UInt32.max)
        return random * (range.upperBound - range.lowerBound) + range.lowerBound
    }
}
