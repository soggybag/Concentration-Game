//
//  GameScene.swift
//  Grid
//
//  Created by mitchell hudson on 5/15/16.
//  Copyright (c) 2016 mitchell hudson. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, GameSquareDelegate {
    
    let numberOfTiles = 16
    var squares = [GameSquare]()
    var currentSquare: GameSquare?
    var playButton: Button!
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            let nodes = nodesAtPoint(location)
            for node in nodes {
                if node.name == "tapNode" {
                    let gameSquare = node.parent as! GameSquare
                    if gameSquare.state == .Closed {
                        gameSquare.state = .Open
                    }
                }
            }
        }
    }
    
    
    func squareDidOpen(gameSquare: GameSquare) {
        if let currentSquare = currentSquare {
            if currentSquare.value == gameSquare.value {
                currentSquare.state = .Matched
                gameSquare.state = .Matched
                checkForGameComplete()
            } else {
                currentSquare.state = .Closed
                gameSquare.state = .Closed
            }
            self.currentSquare = nil
        } else {
            currentSquare = gameSquare
        }
    }
    
    
    func checkForGameComplete() {
        for gameSquare in squares {
            if gameSquare.state != .Matched {
                return
            }
        }
        print("Game Over")
    }
    
    
    func resetGame() {
        for gameSquare in squares {
            gameSquare.state = .Closed
        }
        runAction(SKAction.sequence([
            SKAction.waitForDuration(0.3),
            SKAction.runBlock({ 
                self.shuffleGameTiles()
            })
        ]))
    }
    
    
    func shuffleGameTiles() {
        let values = [Int](1 ... 26)
        let valuesShuffled = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(values) as! [Int]
        var pairs = [Int]()
        for i in 0 ..< 8 {
            pairs.append(valuesShuffled[i])
            pairs.append(valuesShuffled[i])
        }
        let pairsShuffled = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(pairs) as! [Int]
        
        for i in 0 ..< squares.count {
            squares[i].value = pairsShuffled[i]
            squares[i].state = .Closed
        }
    }
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        let defaultButton = SKSpriteNode(color: UIColor.brownColor(), size: CGSize(width: 100, height: 40))
        let activeButton = SKSpriteNode(color: UIColor.orangeColor(), size: CGSize(width: 100, height: 40))
        playButton = Button(defaultImage: defaultButton, activeImage: activeButton, buttonAction: { 
            self.resetGame()
        })
        
        playButton.position.x = size.width / 2
        playButton.position.y = size.height - 40
        playButton.title = "Play"
        addChild(playButton)
        
        
        for n in 0 ..< numberOfTiles {
            let spacing = view.frame.size.width / 4
            let offset = spacing / 2
            
            let x = spacing * CGFloat(n % 4) + offset
            let y = spacing * CGFloat(floor(Double(n) / 4)) + offset
            
            let square = GameSquare() // GameTile()
            square.delegate = self
            square.configureAtLocation(CGPoint(x: x, y: y))
            addChild(square)
            squares.append(square)
        }
        
        shuffleGameTiles()
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}



