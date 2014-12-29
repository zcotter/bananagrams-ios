import UIKit
import XCTest
import bananagrams_ios

class bananagrams_iosTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDictionary() {
        let dict = WordDictionary()
        XCTAssert(dict.search("apple") == true, "Find word")
        XCTAssert(dict.search("orange") == true, "Find word")
        XCTAssert(dict.search("banana") == true, "Find word")
        XCTAssert(dict.search("notaword") == false, "find fake")

        //Dictionary doesn't look for words shorter than 3 characters
        XCTAssert(dict.search("no") == false)
        XCTAssert(dict.search("yes") == true)
        XCTAssert(dict.search("t") == false)
    }

    func testDictionaryPerformance() {
        // This is an example of a performance test case.
        self.measureBlock() {
            let dict = WordDictionary()
            XCTAssert(dict.search("nonzoologically") == true, "Find worst case word")
            XCTAssert(dict.search("nonzoologicallical") == false, "Find bad case non-word")
        }
    }

    func testLetters() {
        for letterValue in UnicodeScalar("a").value...UnicodeScalar("z").value{
            let character = UnicodeScalar(letterValue);
            let letter = Letter(letter: Character(character))
            XCTAssert(letter.points > 0, "\(letter) should be worth points")
        }

        XCTAssert(Letter(letter: "a") == Letter(letter: "a"))
        XCTAssert(Letter(letter: "A") == Letter(letter: "a"))
        XCTAssert(Letter(letter: "a") == Letter(letter: "A"))
        XCTAssert(Letter(letter: "a") != Letter(letter: "b"))

        XCTAssert(Letter(letter: "a").hashValue == Letter(letter: "a").hashValue)
        XCTAssert(Letter(letter: "A").hashValue == Letter(letter: "a").hashValue)
        XCTAssert(Letter(letter: "a").hashValue == Letter(letter: "A").hashValue)
        XCTAssert(Letter(letter: "a").hashValue != Letter(letter: "b").hashValue)

        XCTAssert(PlacedLetter(position: (x: 0, y: 0), letter: "a") == PlacedLetter(position: (x: 0, y: 0), letter: "a"))
        XCTAssert(PlacedLetter(position: (x: 1, y: 0), letter: "a") == PlacedLetter(position: (x: 1, y: 0), letter: "a"))
        XCTAssert(PlacedLetter(position: (x: 0, y: 1), letter: "a") == PlacedLetter(position: (x: 0, y: 1), letter: "a"))

        XCTAssert(PlacedLetter(position: (x: 0, y: 0), letter: "a") != PlacedLetter(position: (x: 1, y: 1), letter: "a"))
        XCTAssert(PlacedLetter(position: (x: 1, y: 0), letter: "a") != PlacedLetter(position: (x: 1, y: 1), letter: "a"))
        XCTAssert(PlacedLetter(position: (x: 0, y: 1), letter: "a") != PlacedLetter(position: (x: 1, y: 1), letter: "a"))

        XCTAssert(PlacedLetter(position: (x: 0, y: 0), letter: "a").hashValue == PlacedLetter(position: (x: 0, y: 0), letter: "a").hashValue)
        XCTAssert(PlacedLetter(position: (x: 1, y: 0), letter: "a").hashValue == PlacedLetter(position: (x: 1, y: 0), letter: "a").hashValue)
        XCTAssert(PlacedLetter(position: (x: 0, y: 1), letter: "a").hashValue == PlacedLetter(position: (x: 0, y: 1), letter: "a").hashValue)

        XCTAssert(PlacedLetter(position: (x: 0, y: 0), letter: "a").hashValue != PlacedLetter(position: (x: 1, y: 1), letter: "a").hashValue)
        XCTAssert(PlacedLetter(position: (x: 1, y: 0), letter: "a").hashValue != PlacedLetter(position: (x: 1, y: 1), letter: "a").hashValue)
        XCTAssert(PlacedLetter(position: (x: 0, y: 1), letter: "a").hashValue != PlacedLetter(position: (x: 1, y: 1), letter: "a").hashValue)
    }

    func testLetterLists(){
        var list = LetterList()
        //test initial
        XCTAssert(list.capacity == 20)
        XCTAssert(list.length == 0)
        XCTAssert(list.gridPositionToIndex((x: 0, y: 0)) == 0)
        XCTAssert(list.gridPositionToIndex((x: 1, y: 0)) == 1)
        XCTAssert(list.gridPositionToIndex((x: 9, y: 0)) == 9)
        XCTAssert(list.gridPositionToIndex((x: 0, y: 1)) == 10)
        XCTAssert(list.gridPositionToIndex((x: 9, y: 1)) == 19)
        XCTAssert(list.getLetterAtGridPosition((x:0, y: 0)) == nil)
        XCTAssert(list.getLetterAtGridPosition((x:1, y: 1)) == nil)

        //test add
        XCTAssert(list.addLetter(Letter(letter: "a")) == true)
        XCTAssert(list.capacity == 20)
        XCTAssert(list.length == 1)
        XCTAssert(list.getLetterAtGridPosition((x:0, y: 0)) == Letter(letter: "a"))

        //test remove
        XCTAssert(list.removeLetterAtGridPosition((x:0, y:0)) == Letter(letter: "a"))
        XCTAssert(list.capacity == 20)
        XCTAssert(list.length == 0)
        XCTAssert(list.getLetterAtGridPosition((x:0, y: 0)) == nil)
        XCTAssert(list.removeLetterAtGridPosition((x:0, y:0)) == nil)

        var testChars:[Character] = ["a", "b", "a", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s"]
        for char in testChars {
            XCTAssert(list.addLetter(Letter(letter: char)) == true)
        }
        for i in 0...9{
            XCTAssert(list.getLetterAtGridPosition((x: i, y: 0)) == Letter(letter: testChars[i]))
            XCTAssert(list.getLetterAtGridPosition((x: i, y: 1)) == Letter(letter: testChars[i + 10]))
        }
        XCTAssert(list.capacity == 20)
        XCTAssert(list.length == 20)
        XCTAssert(list.addLetter(Letter(letter: "j")) == false)

        let get = list.getLetterAtGridPosition((x: 1, y: 1))
        let getNext = list.getLetterAtGridPosition((x: 2, y: 1))

        XCTAssert(list.removeLetterAtGridPosition((x: 1, y: 1)) == get)
        XCTAssert(list.removeLetterAtGridPosition((x: 1, y: 1)) == getNext)
        XCTAssert(list.capacity == 20)
        XCTAssert(list.length == 18)

        for i in 0..<18 {
            XCTAssert(list.removeLetterAtGridPosition((x: 0, y: 0)) != nil)
        }
        XCTAssert(list.capacity == 20)
        XCTAssert(list.length == 0)
    }

    func testBoard(){
        var board = Board()
        XCTAssert(board.canPlaceLetter((x: 0, y: 0)) == true)
        XCTAssert(board.canPlaceLetter((x: 1, y: 1)) == true)
        XCTAssert(board.placeLetter(PlacedLetter(position: (x: 1, y: 1),
            letter: "a")) == true)
        XCTAssert(board.canPlaceLetter((x: 0, y: 0)) == true)
        XCTAssert(board.canPlaceLetter((x: 1, y: 1)) == false)

        //O00000
        //orange
        //Oe0000
        //Od0000
        //O00000
        board = Board()
        let oPos = (x: 0, y: 1)
        let rPos = (x: 1, y: 1)
        let aPos = (x: 2, y: 1)
        let nPos = (x: 3, y: 1)
        let gPos = (x: 4, y: 1)
        let ePos = (x: 5, y: 1)

        let eRedPos = (x: 1, y: 2)
        let dPos = (x: 1, y: 3)
        let o = PlacedLetter(position: oPos, letter: "o")
        let r = PlacedLetter(position: rPos, letter: "r")
        let a = PlacedLetter(position: aPos, letter: "a")
        let n = PlacedLetter(position: nPos, letter: "n")
        let g = PlacedLetter(position: gPos, letter: "g")
        let e = PlacedLetter(position: ePos, letter: "e")

        let eRed = PlacedLetter(position: eRedPos, letter: "e")
        let d = PlacedLetter(position: dPos, letter: "d")

        XCTAssert(board.placeLetter(o) == true)
        XCTAssert(board.placeLetter(r) == true)
        XCTAssert(board.valid == false)
        XCTAssert(board.placeLetter(a) == true)
        XCTAssert(board.placeLetter(n) == true)
        XCTAssert(board.placeLetter(g) == true)
        XCTAssert(board.placeLetter(e) == true)
        XCTAssert(board.valid == true)
        XCTAssert(board.placeLetter(eRed) == true)
        XCTAssert(board.valid == false)
        XCTAssert(board.placeLetter(d) == true)
        XCTAssert(board.valid == true)

        XCTAssert(compareArrays(board.getAdjacents(o.position), b: [r]))
        XCTAssert(compareArrays(board.getAdjacents(r.position), b: [o, eRed, a]))
        XCTAssert(compareArrays(board.placedLetters[r]!, b: [o, eRed, a]))
        XCTAssert(compareArrays(board.getAdjacents(a.position), b: [r, n]))
        XCTAssert(compareArrays(board.getAdjacents(n.position), b: [a, g]))
        XCTAssert(compareArrays(board.getAdjacents(g.position), b: [n, e]))
        XCTAssert(compareArrays(board.getAdjacents(e.position), b: [g]))
        XCTAssert(compareArrays(board.getAdjacents(eRed.position), b: [r, d]))
        XCTAssert(compareArrays(board.getAdjacents(d.position), b: [eRed]))
        XCTAssert(compareArrays(board.placedLetters[d]!, b: [eRed]))

        XCTAssert(board.getLetterAt(oPos) == o)
        XCTAssert(board.getLetterAt(rPos) == r)
        XCTAssert(board.getLetterAt(aPos) == a)
        XCTAssert(board.getLetterAt(nPos) == n)
        XCTAssert(board.getLetterAt(gPos) == g)
        XCTAssert(board.getLetterAt(ePos) == e)
        XCTAssert(board.getLetterAt(eRedPos) == eRed)
        XCTAssert(board.getLetterAt(dPos) == d)

        //validate letter array
        XCTAssert(board.validateWord([r, a, n]))
        XCTAssert(board.validateWord([o, r, a, n, g, e]))
        XCTAssert(board.validateWord([r, a, n, g, e]))
        XCTAssert(board.validateWord([r, eRed, d]))
        XCTAssert(board.validateWord([n, r, a]) == false)

        //validity
        XCTAssert(board.valid)

        //removals
        XCTAssert(board.remove(o) == true)
        XCTAssert(board.remove(o) == false)
        XCTAssert(arrayInclude(board.placedLetters[r]!, target: o) == false)
        XCTAssert(board.remove(r) == true)
        XCTAssert(board.remove(a) == true)
        XCTAssert(board.remove(n) == true)
        XCTAssert(board.remove(o) == false)
        XCTAssert(board.remove(g) == true)
        XCTAssert(arrayInclude(board.placedLetters[e]!, target: g) == false)
        XCTAssert(board.remove(e) == true)
        XCTAssert(board.remove(n) == false)
        XCTAssert(board.remove(r) == false)
        XCTAssert(board.remove(eRed) == true)
        XCTAssert(board.remove(d) == true)
    }

    func compareArrays(a : Array<AnyObject>, b : Array<AnyObject>) -> Bool{
        if(countElements(a) != countElements(b)){
            return false
        }
        let aSet : NSSet = NSSet(array: a)
        let bSet : NSSet = NSSet(array: b)
        return aSet.isEqualToSet(bSet)
    }

    func arrayInclude(array: Array<AnyObject>, target: AnyObject) -> Bool {
        let aSet : NSSet = NSSet(array: array)
        return aSet.containsObject(target)
    }
}