//
//  Button.swift
//  Grid
//
//  Created by mitchell hudson on 5/16/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import SpriteKit

class Button: SKNode {
    var defaultbutton: SKSpriteNode
    var activeButton: SKSpriteNode
    var label = SKLabelNode()
    var action: () -> Void
    
    var title: String = "" {
        didSet {
            label.text = title
        }
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        activeButton.hidden = false
        defaultbutton.hidden = true
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.locationInNode(self)
        if defaultbutton.containsPoint(location) {
            activeButton.hidden = false
            defaultbutton.hidden = true
        } else {
            activeButton.hidden = true
            activeButton.hidden = false
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.locationInNode(self)
        if defaultbutton.containsPoint(location) {
            action()
        }
        
        activeButton.hidden = true
        defaultbutton.hidden = false
    }
    
    
    init(defaultImage: SKSpriteNode, activeImage: SKSpriteNode, buttonAction: () -> Void) {
        defaultbutton = defaultImage
        activeButton = activeImage
        
        activeButton.hidden = true
        action = buttonAction
        
        label.verticalAlignmentMode = .Center
        
        super.init()
        
        userInteractionEnabled = true
        addChild(defaultbutton)
        addChild(activeButton)
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
