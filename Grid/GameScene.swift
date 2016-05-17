//
//  GameScene.swift
//  Grid
//
//  Created by mitchell hudson on 5/15/16.
//  Copyright (c) 2016 mitchell hudson. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, GameTileDelegate {
    
    var popupTime = 0.85
    
    let numberOfTiles = 16
    var tiles = [GameTile]()
    
    var slots = [WhackSlot]()
    
    func createSlotAt(pos: CGPoint) {
        let slot = WhackSlot()
        slot.configureAtPosition(pos)
        addChild(slot)
        slots.append(slot)
    }
    
    
    func didTouchTile(tile: GameTile) {
        tile.show()
    }
    
    
    func shuffleGameTiles() {
        let values = [Int](0 ..< 26)
        let valuesShuffled = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(values) as! [Int]
        var pairs = [Int]()
        for i in 0 ..< 8 {
            pairs.append(valuesShuffled[i])
            pairs.append(valuesShuffled[i])
        }
        let pairsShuffled = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(pairs) as! [Int]
        
        for i in 0 ..< tiles.count {
            tiles[i].value = pairsShuffled[i]
        }
    }
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        
        // createSlotAt(CGPoint(x: 200, y: 500))
        /*let test = GameTile2()
        addChild(test)
        test.position.x = 200
        test.position.y = 500*/
        
        
        for n in 0 ..< numberOfTiles {
            let spacing = view.frame.size.width / 4
            let offset = spacing / 2
            
            let x = spacing * CGFloat(n % 4) + offset
            let y = spacing * CGFloat(floor(Double(n) / 4)) + offset
            
            let tile = GameTile()
            tile.position = CGPoint(x: x, y: y)
            tile.zPosition = CGFloat(n)
            tile.delegate = self
            addChild(tile)
            tiles.append(tile)
        }
        
        shuffleGameTiles()
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}



