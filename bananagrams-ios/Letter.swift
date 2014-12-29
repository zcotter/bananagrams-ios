import Foundation

class Letter : Hashable {
    var letter : String
    var points : Int {
        get {
            switch self.letter {
            case "E", "A", "I", "O", "N", "R", "T", "L", "S", "U":
                return 1
            case "D", "G":
                return 2
            case "B", "C", "M", "P":
                return 3
            case "F", "H", "V", "W", "Y":
                return 4
            case "K":
                return 5
            case "J", "X":
                return 8
            case "Q", "Z":
                return 10
            default:
                fatalError("Letter not found")
            }
        }
    }
    
    var hashValue : Int {
        return letter.hashValue
    }
    
    init(letter : Character){
        self.letter = String(letter).uppercaseString
    }
    
    //TODO draw
}

func ==(left: Letter, right: Letter) -> Bool {
    return left.hashValue == right.hashValue
}