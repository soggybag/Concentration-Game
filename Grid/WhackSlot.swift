//
//  WhackSlot.swift
//  Grid
//
//  Created by mitchell hudson on 5/16/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import SpriteKit

class WhackSlot: SKNode {
    
    var charNode: SKSpriteNode!
    var visible = false
    var isHit = false
    
    func show(hideTime hideTime: Double) {
        if visible { return }
        charNode.runAction(SKAction.moveByX(0, y: 0, duration: 0.05))
        visible = true
        isHit = false
    }
    
    func configureAtPosition(pos: CGPoint) {
        position = pos
        let sprite = SKSpriteNode(imageNamed: "Oval")
        addChild(sprite)
        
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(color: UIColor.magentaColor(), size: CGSize(width: 64, height: 64))
        
        charNode = SKSpriteNode(imageNamed: "1")
        charNode.position = CGPoint(x: 0, y: -24)
        charNode.name = "character"
        cropNode.addChild(charNode)
        
        addChild(cropNode)
    }
}
