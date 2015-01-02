import Foundation

protocol Move {
    func execute(startPosition : (x : Int?, y : Int?)?,
                 endPosition : (x: Int?, y: Int?)?,
                 letter : Letter)

    func makeMove() -> Bool
}

class AbstractMove : Move {
    func execute(startPosition : (x : Int?, y : Int?)?,
        endPosition : (x: Int?, y: Int?)?,
        letter : Letter){
            //TODO send to server, other stuff
    }

    func makeMove() -> Bool {
        fatalError("AbstractMove cannot be instantiated")
    }
}

class MoveFactory {
    class func buildMove(startPosition : (x : Int?, y : Int?)?,
                         endPosition : (x: Int?, y: Int?)?,
                         letter : Letter) -> Move {

    }

    class func buildAndExecuteMove(startPosition : (x : Int?, y : Int?)?,
                                   endPosition : (x: Int?, y: Int?)?,
                                   letter : Letter) -> Bool {

    }
}

class BoardToBoardMove : AbstractMove {

    var origin : PlacedLetter
    var destination : (x: Int?, y: Int?)
    var board : Board

    init(origin: PlacedLetter, destination: (x: Int?, y: Int?), board : Board){
        self.origin = origin
        self.destination = destination
        self.board = board
    }

    override func makeMove() -> Bool {
        if board.canPlaceLetter((x: destination.x!, y: destination.y!)) &&
           board.placeLetter(PlacedLetter(position: (x: destination.x!, y: destination.y!), letter: Character(origin.letter))) {
            execute((x: origin.position.x, y: origin.position.y),
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
            execute((x: letter.position.x, y: letter.position.y),
                     endPosition: (x: nil, y: nil),
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
        let l = PlacedLetter(position: destination, letter: Character(letter.letter))

        if(list.hasLetter(letter) && board.placeLetter(l)){
            list.removeLetter(letter)
            execute((x: nil, y: nil),
                    endPosition: (x: destination.x, y: destination.y),
                    letter: letter)
            return true
        }
        return false
    }
}