//
//  Sprite.swift
//  Sprite-Test
//
//  Created by mitchell hudson on 5/14/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import SpriteKit

class Sprite: SKSpriteNode {
    let kPlayKeyName = "play"
    
    var timePerFrame: NSTimeInterval = 0.1
    var currentFrameSet = ""
    var framesDictionary = [String:[SKTexture]]()
    var isPlaying = false
    
    func addFrameSet(name: String, textureNames: [String]) {
        addFramesWithName(name, textures: makeTextureArrayWithArray(textureNames))
    }
    
    func addFramesWithName(name: String, textures: [SKTexture]) {
        currentFrameSet = name
        framesDictionary[name] = textures
    }
    
    func setFrameWithName(name: String) {
        guard let newTexture = framesDictionary[name]?[0] else {
            print("Frame set with name: \(name) not available")
            return
        }
        currentFrameSet = name
        texture = newTexture
        size = newTexture.size()
    }
    
    func gotoFrame(frame: Int) {
        pause()
        guard let frameTexture = framesDictionary[currentFrameSet]?[frame] else {
            print("Frame \(frame) for set \(currentFrameSet) not available")
            return
        }
        texture = frameTexture
        size = frameTexture.size()
    }
    
    func play(name: String) {
        currentFrameSet = name
        let textures = framesDictionary[currentFrameSet]
        size = framesDictionary[currentFrameSet]![0].size()
        let frameAction = SKAction.animateWithTextures(textures!, timePerFrame: timePerFrame)
        runAction(SKAction.repeatActionForever(frameAction), withKey: kPlayKeyName)
        isPlaying = true
    }
    
    func pause() {
        removeActionForKey(kPlayKeyName)
        isPlaying = false
    }
}


extension Sprite {
    func makeTextureArrayWithArray(array: [String]) -> [SKTexture] {
        var textures = [SKTexture]()
        for name in array {
            textures.append(SKTexture(imageNamed: name))
        }
        
        return textures
    }
    
    func makeTextureArrayWithName(name: String, start: Int, end:Int) -> [SKTexture] {
        var textures = [SKTexture]()
        for i in start...end {
            textures.append(SKTexture(imageNamed: "\(name)\(i)"))
        }
        return textures
    }
    
    
    func makeTextureArrayWithName(name: String, and count:Int) -> [SKTexture] {
        return makeTextureArrayWithName(name, start: 1, end: count)
    }
}


