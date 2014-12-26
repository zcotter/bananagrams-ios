//
//  LetterList.swift
//  bananagrams-ios
//
//  Created by Zach Cotter on 12/22/14.
//  Copyright (c) 2014 Zach Cotter. All rights reserved.
//

import Foundation

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
}