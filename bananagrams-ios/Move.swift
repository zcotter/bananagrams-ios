import Foundation

protocol Move {
    func execute(startPosition : (x : Int, y : Int)?,
                 endPosition : (x: Int, y: Int)?,
                 letter : Letter)

    func makeMove() -> Bool
}

class AbstractMove : Move {
    func execute(startPosition : (x : Int, y : Int)?,
        endPosition : (x: Int, y: Int)?,
        letter : Letter){
            //TODO send to server, other stuff
    }

    func makeMove() -> Bool {
        fatalError("AbstractMove cannot be instantiated")
    }
}

class MoveFactory {
    class func buildMove(startPosition : (x : Int, y : Int)?,
                         endPosition : (x: Int, y: Int)?,
                         letter : Letter,
                         game : (board: Board?, list: LetterList?)) -> Move {
        if startPosition != nil && endPosition != nil && game.board != nil {
            let letter : PlacedLetter = PlacedLetter(position: startPosition!,
                                                     letter: Character(letter.letter))
            return BoardToBoardMove(origin: PlacedLetter(position: startPosition!,
                                                         letter: Character(letter.letter)),
                                    destination: endPosition!,
                                    board: game.board!)
        }
        else if startPosition == nil && endPosition != nil && game.board != nil && game.list != nil{
            return LetterListToBoardMove(letter: letter,
                                         destination: endPosition!,
                                         board: game.board!,
                                         list: game.list!)
        }
        else if startPosition != nil && endPosition == nil && game.list != nil {
            return BoardToLetterListMove(letter: PlacedLetter(position: startPosition!,
                                                             letter: Character(letter.letter)),
                                         board: game.board!,
                                         list: game.list!)
        }
        fatalError("Invalid Move Arguments")
    }

    class func buildAndExecuteMove(startPosition : (x : Int, y : Int)?,
                                   endPosition : (x: Int, y: Int)?,
                                   letter : Letter,
                                   game : (board: Board?, list: LetterList?)) -> Bool {
        return buildMove(startPosition,
                         endPosition: endPosition,
                         letter: letter,
                         game : game).makeMove()
    }
}

class BoardToBoardMove : AbstractMove {

    var origin : PlacedLetter
    var destination : (x: Int, y: Int)
    var board : Board

    init(origin: PlacedLetter, destination: (x: Int, y: Int), board : Board){
        self.origin = origin
        self.destination = destination
        self.board = board
    }

    override func makeMove() -> Bool {
        if board.canPlaceLetter((x: destination.x, y: destination.y)) &&
           board.placeLetter(PlacedLetter(position: destination, letter: Character(origin.letter))) {
            board.remove(origin)
            execute(origin.position,
                    endPosition: destination,
                    letter: origin)
            return true
        }
        return false
    }
}

class BoardToLetterListMove : AbstractMove {
    var letter : PlacedLetter
    var board : Board
    var list : LetterList

    init(letter: PlacedLetter, board: Board, list: LetterList){
        self.letter = letter
        self.board = board
        self.list = list
    }

    override func makeMove() -> Bool {
        if list.addLetter(letter) && board.remove(letter) {
            execute(letter.position,
                    endPosition: nil,
                    letter: letter)
            return true
        }
        return false
    }
}

class LetterListToBoardMove : AbstractMove {
    var letter : Letter
    var destination : (x: Int, y: Int)
    var board : Board
    var list : LetterList

    init(letter : Letter,
         destination : (x: Int, y: Int),
         board : Board,
         list : LetterList){
            self.letter = letter
            self.destination = destination
            self.board = board
            self.list = list
    }

    override func makeMove() -> Bool {
        if(list.hasLetter(letter) && board.placeLetter(PlacedLetter(position: destination, letter: Character(letter.letter)))){
            list.removeLetter(letter)
            execute(nil,
                    endPosition: (x: destination.x, y: destination.y),
                    letter: letter)
            return true
        }
        return false
    }
}