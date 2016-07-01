//
//  GameSquare.swift
//  Grid
//
//  Created by mitchell hudson on 5/18/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import SpriteKit


enum GameSquareState {
    case Closing
    case Closed
    case Opening
    case Open
    case Matched
}

protocol GameSquareDelegate {
    func squareDidOpen(gameSquare: GameSquare)
}

class GameSquare: SKNode {
    
    let squareSize:CGFloat = 80
    var state = GameSquareState.Closed {
        didSet {
            switch state {
            case .Closed:
                hide()
            case .Closing:
                break
            case .Matched:
                break
            case .Open:
                show()
            case .Opening:
                break
            }
        }
    }
    var delegate: GameSquareDelegate?
    var sprite: SKSpriteNode!
    var value: Int = 0 {
        didSet {
            setTileNumber(value)
        }
    }
    
    
    func show() {
        sprite.removeAllActions()
        let moveUp = SKAction.moveToY(0, duration: 0.3)
        moveUp.timingMode = .EaseOut
        sprite.runAction(SKAction.sequence([
            moveUp,
            SKAction.runBlock({ 
                if let delegate = self.delegate {
                    delegate.squareDidOpen(self)
                }
            })
        ]))
    }
    
    
    func hide() {
        sprite.removeAllActions()
        let moveDown = SKAction.moveToY(-squareSize, duration: 0.3)
        moveDown.timingMode = .EaseIn
        sprite.runAction(moveDown) {
            self.state = .Closed
        }
    }
    
    func setTile(textureName: String) {
        let texture = SKTexture(imageNamed: textureName)
        sprite.texture = texture
        sprite.size = texture.size()
    }
    
    func setTileNumber(textureNumber: Int) {
        setTile("\(textureNumber)")
    }
    
    
    func maskNode(color: SKColor) -> SKShapeNode {
        let rect = CGRect(x: squareSize / -2, y: squareSize / -2, width: squareSize, height: squareSize)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 20)
        let masknode = SKShapeNode(path: path.CGPath)
        masknode.fillColor = color
        masknode.strokeColor = color
        masknode.lineWidth = 0
        masknode.name = "cropNode"
        return masknode
    }
    
    func configureAtLocation(location: CGPoint) {
        position = location
        let cropNode = SKCropNode()
        cropNode.name = "cropNode"
        cropNode.zPosition = 1
        cropNode.maskNode = maskNode(SKColor.orangeColor())
        
        sprite = SKSpriteNode(imageNamed: "1")
        sprite.name = "sprite"
        sprite.position.y = -squareSize
        sprite.name = "sprite"
        cropNode.addChild(sprite)
        addChild(cropNode)
        
        let tapNode = maskNode(SKColor(white: 1, alpha: 0.5))
        tapNode.zPosition = -1
        tapNode.name = "tapNode"
        addChild(tapNode)
    }
    
}
