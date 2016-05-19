# Concentration-Game

Simple Matching Game written in Swift using SpriteKit and GamePlayKit. The goal of the game is to find the matched pairs
of tiles. 

This example uses a few useful and interesting ideas that can be applied in many projects. 

##arrayByShufflingObjectsInArray

This method is part of GamePlayKit, it provides an easy way to randomize the contents of an array. 

    GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(array)

Since the grid has 16 squares there are 8 matches to search for. The game prepares by choosing 8 values from a list of 26.
Adding two copies of each to an array that will be used for the current game. The first array of 26 is shuffled, and the first
8 values are each added twice. The second array is then shuffled before the values are assigned to the game board. 

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

##SKCropNode 

SKCropNode acts as a mask for it's child nodes. Use to create masking effects. This game uses a cropNode to allow the 
matching images to slide up into view as if in a window. 

The GameSquare class makes use of SKCropNode. GameSquare is an SKNode containing a cropNode, sprite, and tapNode. _I had some 
trouble with SKCropNode. Specifically I had some strange behavior when GameSquare subclassed SKCropNode. Making cropNode a child of an SKNode worked well. I also had issues receiving touch events on objects outside of the masked areas. To solve this I created "tapNode", an SKSpriteNode, which covers the tappable area._

GameSquare is structured as a node with several child nodes
    GameSquare
        cropNode
            maskNode *
            sprite
        tapNode

![Screenshot][Simulator Screen Shot May 19, 2016, 9.50.07 AM.png]
