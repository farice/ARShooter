//
//  Ship.swift
//  ARViewer
//
//  Created by Faris Sbahi on 6/6/17.
//  Copyright © 2017 Faris Sbahi. All rights reserved.
//

import UIKit
import SceneKit

// Floating boxes that appear around you
class Ship: SCNNode {
    override init() {
        super.init()
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        self.geometry = box
        let shape = SCNPhysicsShape(geometry: box, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
        self.physicsBody?.isAffectedByGravity = false
        
        // see http://texnotes.me/post/5/ for details on collisions and bit masks
        self.physicsBody?.categoryBitMask = CollisionCategory.ship.rawValue
        self.physicsBody?.contactTestBitMask = CollisionCategory.bullets.rawValue
        
        // add texture
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "galaxy")
        self.geometry?.materials  = [material, material, material, material, material, material]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
