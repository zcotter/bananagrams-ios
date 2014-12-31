import Foundation

protocol Move {
    func execute(startPosition : (x : Int?, y : Int?)?,
                 endPosition : (x: Int?, y: Int?)?,
                 letter : Letter)

    func makeMove() -> Bool
}

class AbstractMove : Move {

    init(){
        fatalError("AbstractMove cannot be instantiated")
    }

    func execute(startPosition : (x : Int?, y : Int?)?,
        endPosition : (x: Int?, y: Int?)?,
        letter : Letter){
            //TODO send to server, other stuff
    }

    func makeMove() -> Bool {
        fatalError("AbstractMove cannot be instantiated")
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
        if board.canPlaceLetter(destination) == true {
            execute(origin.position,
                    endPosition: destination,
                    letter: origin)
            return true
        }
        return false
    }


}
