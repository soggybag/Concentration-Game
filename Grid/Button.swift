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
    var action: () -> Void
    
    
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
    
    
    init(defaultImage: String, activeImage: String, buttonAction: () -> Void) {
        defaultbutton = SKSpriteNode(imageNamed: defaultImage)
        activeButton = SKSpriteNode(imageNamed: activeImage)
        
        activeButton.hidden = true
        action = buttonAction
        
        super.init()
        
        userInteractionEnabled = true
        addChild(defaultbutton)
        addChild(activeButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
