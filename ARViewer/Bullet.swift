//
//  Bullet.swift
//  ARViewer
//
//  Created by Faris Sbahi on 6/6/17.
//  Copyright © 2017 Faris Sbahi. All rights reserved.
//

import UIKit
import SceneKit

class Bullet: SCNNode {
    override init () {
        super.init()
        self.geometry = SCNSphere(radius: 0.025)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node: self, options: nil))
        self.physicsBody?.isAffectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionCategory.bullets.rawValue
        self.physicsBody?.contactTestBitMask = -1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
