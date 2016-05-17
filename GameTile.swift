//
//  GameTile.swift
//  Grid
//
//  Created by mitchell hudson on 5/15/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import SpriteKit

protocol GameTileDelegate {
    func didTouchTile(tile: GameTile)
}

class GameTile: SKCropNode {
    
    let shape = SKShapeNode()
    let sprite = Sprite()
    let numberOfAliens = 26
    let size = CGSize(width: 80, height: 80)
    
    var delegate: GameTileDelegate?
    var tileHidden = true
    
    var value: Int = 0 {
        didSet {
            sprite.gotoFrame(value)
        }
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let delegate = delegate {
            delegate.didTouchTile(self)
        }
    }
    
    
    
    func show() {
        print("Show Tile")
        tileHidden = !tileHidden
        sprite.removeAllActions()
        if tileHidden {
            sprite.runAction(SKAction.moveToY(-80, duration: 0.2))
        } else {
            sprite.runAction(SKAction.moveToY(0, duration: 0.2))
        }
    }
    
    
    
    
    
    
    func setupShape() {
        let rect = CGRect(origin: CGPointZero, size: size)
        
        shape.path = UIBezierPath(roundedRect: rect, cornerRadius: 20).CGPath
        shape.position.x = size.width / -2
        shape.position.y = size.height / -2
        shape.fillColor = UIColor.orangeColor()
        shape.zPosition = -1
        
        addChild(shape)
    }
    
    
    func setupSprite() {
        var alienFrameNames = [String]()
        for n in 1...numberOfAliens {
            alienFrameNames.append("\(n)")
        }
        
        sprite.position.y = -22
        sprite.zPosition = 11
        
        sprite.addFrameSet("aliens", textureNames: alienFrameNames)
        sprite.setFrameWithName("aliens")
        sprite.gotoFrame(0)
        
        addChild(sprite)
    }
    
    
    func setup() {
        userInteractionEnabled = false
        name = "tile"
        // color = UIColor.orangeColor()
        
        setupShape()
        setupSprite()
        
        userInteractionEnabled = true
        maskNode = shape
    }
    
    
    override init() {
        super.init()
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
