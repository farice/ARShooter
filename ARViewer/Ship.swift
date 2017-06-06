//
//  Ship.swift
//  ARViewer
//
//  Created by Faris Sbahi on 6/6/17.
//  Copyright © 2017 Faris Sbahi. All rights reserved.
//

import UIKit
import SceneKit

class Ship: SCNNode {
    override init() {
        super.init()
        self.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node: self, options: nil))
        self.physicsBody?.isAffectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionCategory.ship.rawValue
        self.physicsBody?.contactTestBitMask = -1
        
        // add texture
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "faris")
        self.geometry?.materials  = [material, material, material, material, material, material]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
