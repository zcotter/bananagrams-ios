import Foundation
import SpriteKit

class LetterList {
    let lettersPerRow:Int = 10
    let numberOfRows: Int = 2
    var letters:[Letter]
    var length: Int {
        get {
            return countElements(letters)
        }
    }
    var capacity: Int {
        get {
            return lettersPerRow * numberOfRows
        }
    }
    
    init(){
        letters = []
    }
    
    func gridPositionToIndex(position: (x:Int, y:Int)) -> Int {
        let column = position.x
        let row = position.y
        return column + (row * lettersPerRow)
    }
    
    func getLetterAtGridPosition(position: (x: Int, y:Int)) -> Letter? {
        let index = gridPositionToIndex(position)
        if index > length - 1 || length == 0{
            return nil
        }
        else {
            return letters[index]
        }
    }
    
    func addLetter(newLetter: Letter) -> Bool {
        if length + 1 > capacity{
            return false
        }
        else{
            letters.append(newLetter)
            return true
        }
    }
    
    func removeLetterAtGridPosition(position: (x:Int, y:Int)) -> Letter? {
        let index = gridPositionToIndex(position)
        if index > length - 1{
            return nil
        }
        else{
            return letters.removeAtIndex(index)
        }
    }

    func removeLetter(target : Letter) -> Bool {
        for (index, letter) in enumerate(letters) {
            if(letter == target){
                letters.removeAtIndex(index)
                return true
            }
        }
        return false
    }

    func hasLetter(target : Letter) -> Bool {
        for letter in letters {
            if(letter == target){
                return true
            }
        }
        return false
    }

    func draw(scene : BananagramsScene) {
        for x in 0...9 {
            for y in 0...1 {
                let index = y * 10 + x
                if index < length {
                    var letterNode : SKSpriteNode = letters[index].toSpriteNode()
                    let width = scene.letterListWidth / lettersPerRow
                    let height = scene.letterListHeight / numberOfRows
                    letterNode.size = CGSize(width: width,
                                             height: height)
                    letterNode.position = CGPoint(x: x * width,
                                                  y: y * height)
                    letterNode.anchorPoint = CGPoint(x: 0, y: 0)
                    scene.addChild(letterNode)
                }
            }
        }
    }

    func touchPositionToGridPosition(touch: (x: Int, y: Int), dimensions: (width: Int, height: Int, yOffset: Int)) -> (x: Int, y: Int){
        let x = touch.x / (lettersPerRow * dimensions.width)
        let y = (touch.y - dimensions.yOffset) / (numberOfRows * dimensions.height)
        return (x: x, y: y)
    }
}