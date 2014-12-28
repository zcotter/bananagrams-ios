//
//  Board.swift
//  bananagrams-ios
//
//  Created by Zach Cotter on 12/22/14.
//  Copyright (c) 2014 Zach Cotter. All rights reserved.
//

import Foundation

class Board {
    var placedLetters: [PlacedLetter: Bool]
    var score: Int {
        get {
            var score: Int = 0
            for (letter, validity) in placedLetters{
                if validity{
                    score += letter.points
                }
            }
            return score
        }
    }
    
    init(){
        placedLetters = [PlacedLetter: Bool]()
    }
    
    func canPlaceLetter(position: (x: Int, y: Int)) -> Bool{
        for letter in placedLetters.keys {
            if letter.position.x == position.x && letter.position.y == position.y {
                return false
            }
        }
        return true
    }
    
    func placeLetter(letter: PlacedLetter) -> Bool {
        if canPlaceLetter(letter.position) {
            placedLetters[letter] = false
            // TODO validate
            return true
        }
        else {
            return false
        }
    }

    func getLetterAt(position: (x: Int, y: Int)) -> PlacedLetter? {
        for letter in placedLetters.keys {
            if letter.position.x == position.x && letter.position.y == position.y {
                return letter
            }
        }
        return nil
    }

    func remove(target : PlacedLetter) -> Bool {
        if(placedLetters[target] != nil){
            placedLetters[target] = nil
            // TODO validate adjacents
            return true
        }
        else {
            return false
        }
    }
    
    func getAdjacents(position: (x: Int, y: Int)) -> [PlacedLetter] {
        var adjacents : [PlacedLetter] = []
        for letter in placedLetters.keys {
            let xDiff = abs(position.x - letter.position.x)
            let yDiff = abs(position.y - letter.position.y)
            if ((xDiff == 1 && yDiff == 0) || (xDiff == 0 && yDiff == 1)) {
                adjacents.append(letter)
            }
            if(countElements(adjacents) == 4){
                break
            }
        }
        return adjacents
    }
}