import Foundation

class PlacedLetter : Letter {
    var position: (x:Int, y:Int)
    var valid: Bool
    
    override var hashValue : Int {
        
        //var hashcode: Int = super.hashValue
        var hashcode: Int
        hashcode = super.hashValue
        hashcode += 3 &* hashcode &+ position.x
        hashcode += 5 &* hashcode &+ position.y
        return hashcode
    }

    
    init(position: (x: Int, y: Int), letter : Character){
        self.position = position
        self.valid = false
        super.init(letter: letter)
    }

    func description() -> String {
        return "\(letter): (\(position.x), \(position.y)) " + (valid ? "valid" : "invalid")
    }
    
    //TODO draw
}

func ==(left: PlacedLetter, right: PlacedLetter) -> Bool {
    return left.hashValue == right.hashValue
}

func !=(left: PlacedLetter, right: PlacedLetter) -> Bool {
    return left.hashValue != right.hashValue
}

