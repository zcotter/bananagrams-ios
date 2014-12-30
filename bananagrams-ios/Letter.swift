import Foundation
import SpriteKit

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

    var frequency : Int {
        get {
            switch self.letter {
            case "E": return 12
            case "A", "I": return 9
            case "O": return 8
            case "N", "R", "T": return 6
            case "L", "S", "U", "D": return 4
            case "G": return 3
            case "B", "C", "M", "P", "F", "H", "V", "W", "Y": return 2
            case "K", "J", "X", "Q", "Z": return 1
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
    
    func toSpriteNode() -> SKSpriteNode {
        return SKSpriteNode(imageNamed: letter.lowercaseString)
    }

    class func alphabet() -> [Character] {
        var alphabet : [Character] = []
        for letterValue in UnicodeScalar("a").value...UnicodeScalar("z").value{
            let character = UnicodeScalar(letterValue)
            alphabet.append(Character(character))
        }
        return alphabet
    }
}

func ==(left: Letter, right: Letter) -> Bool {
    return left.hashValue == right.hashValue
}