import SpriteKit
import Foundation

class BananagramsScene : SKScene {
    let testLetter = SKSpriteNode(imageNamed: "b")
    var board = Board()
    var letterList = LetterList()

    var width: Int {
        get {
            return self.size.width.description.componentsSeparatedByString(".")[0].toInt()!
        }
    }

    var height: Int {
        get {
            return self.size.height.description.componentsSeparatedByString(".")[0].toInt()!
        }
    }

    var boardHeight: Int {
        get {
            return Int((10.0 / 12.0) * Float(height))
        }
    }

    var boardWidth: Int {
        get {
            return width
        }
    }

    var letterListHeight: Int {
        get {
            return Int((2.0 / 12.0) * Float(height))
        }
    }

    var letterListWidth: Int {
        get {
            return width
        }
    }

    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        makeTestBoard()
        board.draw(self)
        makeLetterList()
        letterList.draw(self)
    }

    func makeLetterList(){
        let alphabet = Letter.alphabet()
        var tileBag : [Letter] = []
        for letter in alphabet {
            let tile = Letter(letter: letter)
            for i in 1...tile.frequency {
                tileBag.append(tile)
            }
        }

        for i in 1...20 {
            let index : Int = Int(arc4random_uniform(UInt32(tileBag.count)))
            letterList.addLetter(tileBag.removeAtIndex(index))
        }
    }

    func makeTestBoard(){
        let oPos = (x: 0, y: 8)
        let rPos = (x: 1, y: 8)
        let aPos = (x: 2, y: 8)
        let nPos = (x: 3, y: 8)
        let gPos = (x: 4, y: 8)
        let ePos = (x: 5, y: 8)

        let eRedPos = (x: 1, y: 7)
        let dPos = (x: 1, y: 6)
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