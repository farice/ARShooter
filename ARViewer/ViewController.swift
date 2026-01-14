//
//  ViewController.swift
//  ARViewer
//  http://texnotes.me/post/5/ for tutorial
//
//  Created by Faris Sbahi on 6/6/17.
//  Copyright © 2017 Faris Sbahi. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate, SCNPhysicsContactDelegate, GameManagerDelegate {

    // MARK: - Outlets

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var scoreLabel: UILabel!

    // MARK: - Properties

    private var gameManager: GameManager!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupScene()
        setupGameManager()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureARSession()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    // MARK: - Setup

    private func setupScene() {
        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.scene = SCNScene()
        sceneView.scene.physicsWorld.contactDelegate = self
    }

    private func setupGameManager() {
        gameManager = GameManager(sceneView: sceneView)
        gameManager.delegate = self
        gameManager.reset()
        gameManager.addNewShip()
    }

    private func configureARSession() {
        let configuration = createARConfiguration()
        sceneView.session.run(configuration)
    }

    private func createARConfiguration() -> ARConfiguration {
        if ARWorldTrackingConfiguration.isSupported {
            let config = ARWorldTrackingConfiguration()
            config.planeDetection = .horizontal
            return config
        } else {
            return AROrientationTrackingConfiguration()
        }
    }

    // MARK: - Actions

    @IBAction func didTapScreen(_ sender: UITapGestureRecognizer) {
        gameManager.fireBullet()
    }

    // MARK: - ARSCNViewDelegate

    func session(_ session: ARSession, didFailWithError error: Error) {
        print("Session failed with error: \(error.localizedDescription)")
    }

    func sessionWasInterrupted(_ session: ARSession) {
        // Inform user that the session has been interrupted
    }

    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking if consistent tracking is required
    }

    // MARK: - SCNPhysicsContactDelegate

    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        gameManager.handleContact(contact)
    }

    // MARK: - GameManagerDelegate

    func gameManager(_ manager: GameManager, didUpdateScore score: Int) {
        DispatchQueue.main.async {
            self.scoreLabel.text = String(score)
        }
    }
}

// MARK: - Collision Categories

struct CollisionCategory: OptionSet {
    let rawValue: Int

    static let bullets = CollisionCategory(rawValue: 1 << 0)
    static let ship = CollisionCategory(rawValue: 1 << 1)
}

// MARK: - Device Capability Check

extension utsname {

    /// Device models with at least A9 processor that support ARWorldTrackingConfiguration
    private static let a9CompatibleDevices: Set<String> = [
        // iPhones with A9 or later
        "iPhone8,1", "iPhone8,2", "iPhone8,4",  // iPhone 6s, 6s Plus, SE
        "iPhone9,1", "iPhone9,2", "iPhone9,3", "iPhone9,4",  // iPhone 7, 7 Plus
        // iPads with A9 or later
        "iPad6,3", "iPad6,4",  // iPad Pro 9.7"
        "iPad6,7", "iPad6,8",  // iPad Pro 12.9"
        "iPad6,11", "iPad6,12" // iPad 5th gen
    ]

    /// Checks if device has at least A9 chip for AR configuration
    /// Note: Prefer using ARWorldTrackingConfiguration.isSupported instead of this method
    func hasAtLeastA9() -> Bool {
        var systemInfo = self
        uname(&systemInfo)
        let deviceModel = withUnsafePointer(to: &systemInfo.machine.0) { ptr in
            String(cString: ptr)
        }
        return Self.a9CompatibleDevices.contains(deviceModel)
    }
}
