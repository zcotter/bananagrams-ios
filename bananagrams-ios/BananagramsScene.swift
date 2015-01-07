import SpriteKit
import Foundation

class BananagramsScene : SKScene {
    let testLetter = SKSpriteNode(imageNamed: "b")
    var board = Board()
    var letterList = LetterList()
    var firstTouch : (x: Int, y: Int)?
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

    func repaint(){
        
        self.removeAllChildren()
        board.draw(self)
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

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var xSum = CGFloat(0)
        var ySum = CGFloat(0)
        for t in touches {
            xSum = xSum.advancedBy(CGFloat(t.locationInView!(view! as SKView).x))
            ySum = ySum.advancedBy(CGFloat(t.locationInView!(view! as SKView).y))
        }
        let x = xSum.description.componentsSeparatedByString(".")[0].toInt()! / touches.count
        let y = ySum.description.componentsSeparatedByString(".")[0].toInt()! / touches.count
        println("First touch: \(x), \(y)")
        firstTouch = (x: x, y: y)
    }

    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        var xSum = CGFloat(0)
        var ySum = CGFloat(0)
        for t in touches {
            xSum = xSum.advancedBy(CGFloat(t.locationInView!(view! as SKView).x))
            ySum = ySum.advancedBy(CGFloat(t.locationInView!(view! as SKView).y))
        }
        let x = xSum.description.componentsSeparatedByString(".")[0].toInt()! / touches.count
        let y = ySum.description.componentsSeparatedByString(".")[0].toInt()! / touches.count
        println("Second touch: \(x), \(y)")
        handleDrag(firstTouch!, end: (x: x, y: y))
    }

    func handleDrag(start: (x: Int, y: Int), end: (x: Int, y: Int)) {
        let boardDims = (width: boardWidth, height: boardHeight)
        if touchInBoard(start){
            let startBoard = board.touchLocationToBoardLocation(start, dimensions: boardDims)
            if touchInBoard(end) {
                let endBoard = board.touchLocationToBoardLocation(end, dimensions: boardDims)
                BoardToBoardMove(origin: board.getLetterAt(startBoard)!,
                                 destination: endBoard,
                                 board: board).makeMove()
            }
            else {
                println(boardDims)
                println(startBoard)
                BoardToLetterListMove(letter: board.getLetterAt(startBoard)!,
                                      board: board,
                                      list: letterList).makeMove()
            }
        }
        else {
            let startList = letterList.touchPositionToGridPosition(start,
                                                                   dimensions: (width: letterListWidth,
                                                                    height: letterListHeight,
                                                                    yOffset: boardHeight))
            if touchInBoard(end){
                let endBoard = board.touchLocationToBoardLocation(end, dimensions: boardDims)
                let letter = letterList.getLetterAtGridPosition(startList)
                if letter != nil {
                    LetterListToBoardMove(letter: letter!,
                                          destination: endBoard,
                                          board: board,
                                          list: letterList).makeMove()
                }
            }
        }
        repaint()
    }

    private func touchInBoard(touch: (x: Int, y: Int)) -> Bool {
        return touch.y < boardHeight
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