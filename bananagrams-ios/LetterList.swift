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

    func draw(scene : BananagramsScene) {
        println(self.length)
        for i in 0...9 {
            for j in 0...1 {
                var letterNode : SKSpriteNode = letters[j * 10 + i].toSpriteNode()
                let width = scene.letterListWidth / lettersPerRow
                let height = scene.letterListHeight / numberOfRows
                letterNode.size = CGSize(width: width,
                                         height: height)
                letterNode.position = CGPoint(x: i * width,
                                              y: j * height)
                letterNode.anchorPoint = CGPoint(x: 0, y: 0)
                scene.addChild(letterNode)
            }
        }
    }
}