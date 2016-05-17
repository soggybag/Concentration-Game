//
//  GameTile2.swift
//  Grid
//
//  Created by mitchell hudson on 5/17/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import SpriteKit

class GameTile2: SKCropNode {
    
    var shape = SKShapeNode()
    var sprite = Sprite()
    var size = CGSize(width: 80, height: 80)
    
    override init() {
        super.init()
        
        let rect = CGRect(origin: CGPointZero, size: size)
        shape.path = UIBezierPath(roundedRect: rect, cornerRadius: 20).CGPath
        shape.position.x = size.width / -2
        shape.position.y = size.height / -2
        shape.fillColor = UIColor(white: 1, alpha: 1)
        shape.zPosition = 0
        addChild(shape)
        
        maskNode = shape
        
        let numberOfAliens = 26
        var alienFrameNames = [String]()
        for n in 1...numberOfAliens {
            alienFrameNames.append("\(n)")
        }
        
        sprite.position.y = -22
        
        sprite.addFrameSet("aliens", textureNames: alienFrameNames)
        sprite.setFrameWithName("aliens")
        sprite.gotoFrame(0)
        
        addChild(sprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
