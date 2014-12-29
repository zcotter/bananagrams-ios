import SpriteKit
import Foundation

class BoardScene : SKScene {
    let testLetter = SKSpriteNode(imageNamed: "b")

    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        testLetter.position = CGPoint(x: 10, y: 10)
        addChild(testLetter)
    }
}