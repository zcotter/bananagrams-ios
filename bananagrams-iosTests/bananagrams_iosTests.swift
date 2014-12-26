//
//  bananagrams_iosTests.swift
//  bananagrams-iosTests
//
//  Created by Zach Cotter on 12/24/14.
//  Copyright (c) 2014 Zach Cotter. All rights reserved.
//

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
    
    
    
}
