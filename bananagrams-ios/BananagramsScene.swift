import SpriteKit
import Foundation

class BananagramsScene : SKScene {
    let testLetter = SKSpriteNode(imageNamed: "b")
    var board = Board()
    var letterList = LetterList()
    var firstTouch : (x: Int, y: Int)?
    var currentLetterNode : SKSpriteNode? = nil
    var firstMove = false
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
        firstTouch = getTouchFromSet(touches)
        if touchInBoard(firstTouch!){
            let boardTouch = board.touchLocationToBoardLocation(firstTouch!, dimensions: (width: boardWidth, height: boardHeight))
            let currentLetter = board.getLetterAt(boardTouch)
            if currentLetter != nil {
                currentLetterNode = currentLetter!.toSpriteNode()
            }
        }
        else {
            let letterLocation = letterList.touchPositionToGridPosition(firstTouch!,
                dimensions: (width: letterListWidth,
                    height: letterListHeight,
                    yOffset: boardHeight))
            let currentLetter = letterList.getLetterAtGridPosition(letterLocation)
            if currentLetter != nil {
                currentLetterNode = currentLetter!.toSpriteNode()
            }
        }
        firstMove = true
    }

    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let touch = getTouchFromSet(touches)
        if currentLetterNode != nil {
            let width = boardWidth / board.dimension
            let height = boardHeight / board.dimension
            currentLetterNode!.size = CGSize(width: width,
            height: height)
            let xPos = touch.x
            let yPos = abs(touch.y - self.height)
            println(yPos)
            currentLetterNode!.position = CGPoint(x: xPos,
                                                  y: yPos)
            //currentLetterNode!.anchorPoint = CGPoint(x: 0, y: 0)
            if firstMove {
                addChild(currentLetterNode!)
                firstMove = false
            }
        }
    }

    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        handleDrag(firstTouch!, end: getTouchFromSet(touches))
        if currentLetterNode != nil {
            currentLetterNode!.removeFromParent()
        }
        currentLetterNode = nil
    }

    private func getTouchFromSet(touches: NSSet) -> (x: Int, y: Int){
        var xSum = CGFloat(0)
        var ySum = CGFloat(0)
        for t in touches {
            xSum = xSum.advancedBy(CGFloat(t.locationInView!(view! as SKView).x))
            ySum = ySum.advancedBy(CGFloat(t.locationInView!(view! as SKView).y))
        }
        let x = xSum.description.componentsSeparatedByString(".")[0].toInt()! / touches.count
        let y = ySum.description.componentsSeparatedByString(".")[0].toInt()! / touches.count
        return (x: x, y: y)
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
}