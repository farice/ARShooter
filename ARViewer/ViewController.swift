//
//  ViewController.swift
//  ARViewer
//
//  Created by Faris Sbahi on 6/6/17.
//  Copyright © 2017 Faris Sbahi. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate, SCNPhysicsContactDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        //let scene = SCNScene(named: "art.scnassets/ship.scn")!
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        sceneView.scene.physicsWorld.contactDelegate = self
        
        let cubeNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        cubeNode.position = SCNVector3(0, 0, -0.5) // SceneKit/AR coordinates are in meters
        cubeNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node: cubeNode, options: nil))
        cubeNode.physicsBody?.isAffectedByGravity = false
        cubeNode.physicsBody?.categoryBitMask = CollisionCategory.ship.rawValue
        cubeNode.physicsBody?.contactTestBitMask = -1
        sceneView.scene.rootNode.addChildNode(cubeNode)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        configuration.planeDetection = ARWorldTrackingSessionConfiguration.PlaneDetection.horizontal
        print(configuration.planeDetection)
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // This visualization covers only detected planes.
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        print("flat plane detected")
        
        // Create a SceneKit plane to visualize the node using its position and extent.
        let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        let planeNode = SCNNode(geometry: plane)
        planeNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z)
        
        // SCNPlanes are vertically oriented in their local coordinate space.
        // Rotate it to match the horizontal orientation of the ARPlaneAnchor.
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
        
        // ARKit owns the node corresponding to the anchor, so make the plane a child node.
        node.addChildNode(planeNode)
    }
    
    // MARK: - Actions
    
    @IBAction func didTapScreen(_ sender: UITapGestureRecognizer) {
        let bulletsNode = SCNNode(geometry: SCNSphere(radius: 0.05))
        bulletsNode.position = SCNVector3(0, 0, -0.2) // SceneKit/AR coordinates are in meters
        bulletsNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node: bulletsNode, options: nil))
        bulletsNode.physicsBody?.isAffectedByGravity = false
        bulletsNode.physicsBody?.categoryBitMask = CollisionCategory.bullets.rawValue
        bulletsNode.physicsBody?.contactTestBitMask = -1
        
        bulletsNode.physicsBody?.applyForce(SCNVector3(0, 0, -1), asImpulse: true)
        sceneView.scene.rootNode.addChildNode(bulletsNode)
        
    }
    
    // MARK: -
    /*
    func getUserDirection() -> SCNVector3 {
        self.sceneView.session.currentFrame?.
    } */
    
    // MARK: - Contact Delegate
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        //print("did begin contact", contact.nodeA.physicsBody!.categoryBitMask, contact.nodeB.physicsBody!.categoryBitMask)
        if contact.nodeA.physicsBody?.categoryBitMask == CollisionCategory.ship.rawValue || contact.nodeB.physicsBody?.categoryBitMask == CollisionCategory.ship.rawValue {
            print("HIT SHIP")
        }
    }
    
}

struct CollisionCategory: OptionSet {
    let rawValue: Int
    
    static let bullets  = CollisionCategory(rawValue: 1 << 0)
    static let ship = CollisionCategory(rawValue: 1 << 1)
}
