import SpriteKit
import Foundation

class BananagramsScene : SKScene {
    let testLetter = SKSpriteNode(imageNamed: "b")
    var board = Board()

    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        makeTestBoard()
        board.draw(self)
    }

    func makeTestBoard(){
        let oPos = (x: 0, y: 1)
        let rPos = (x: 1, y: 1)
        let aPos = (x: 2, y: 1)
        let nPos = (x: 3, y: 1)
        let gPos = (x: 4, y: 1)
        let ePos = (x: 5, y: 1)

        let eRedPos = (x: 1, y: 2)
        let dPos = (x: 1, y: 3)
        let o = PlacedLetter(position: oPos, letter: "o")
        let r = PlacedLetter(position: rPos, letter: "r")
        let a = PlacedLetter(position: aPos, letter: "a")
        let n = PlacedLetter(position: nPos, letter: "n")
        let g = PlacedLetter(position: gPos, letter: "g")
        let e = PlacedLetter(position: ePos, letter: "e")

        let eRed = PlacedLetter(position: eRedPos, letter: "e")
        let d = PlacedLetter(position: dPos, letter: "d")
        board.placeLetter(o)
        board.placeLetter(r)
        board.placeLetter(a)
        board.placeLetter(n)
        board.placeLetter(g)
        board.placeLetter(e)
        board.placeLetter(eRed)
        board.placeLetter(d)
    }
}