//
//  Board.swift
//  bananagrams-ios
//
//  Created by Zach Cotter on 12/22/14.
//  Copyright (c) 2014 Zach Cotter. All rights reserved.
//

import Foundation

class Board {
    var placedLetters: [PlacedLetter: [PlacedLetter]]
    var score: Int {
        get {
            var score: Int = 0
            for letter in placedLetters.keys{
                if letter.valid {
                    score += letter.points
                }
            }
            return score
        }
    }
    var valid: Bool {
        get {
            var valid = true
            for letter in placedLetters.keys {
                if(!letter.valid) {
                    valid = false
                }
            }
            return valid
        }
    }
    
    let dictionary: WordDictionary
    
    init(){
        placedLetters = [PlacedLetter: [PlacedLetter]]()
        dictionary = WordDictionary()
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
            let adjacents = getAdjacents(letter.position)
            placedLetters[letter] = adjacents
            for adjacent in adjacents {
                placedLetters[adjacent]!.append(letter)
            }
            validateFrom(letter)
            return true
        }
        else {
            return false
        }
    }

    private func validateFrom(start: PlacedLetter){
        let up = getContinuousFrom(start, direction: (xDiff: 0, yDiff: -1), accumulator: [])
        let down = getContinuousFrom(start, direction: (xDiff: 0, yDiff: 1), accumulator: [])
        let left = getContinuousFrom(start, direction: (xDiff: -1, yDiff: 0), accumulator: [])
        let right = getContinuousFrom(start, direction: (xDiff: 1, yDiff: 0), accumulator: [])

        let horizontal = reverse(left) + [start] + reverse(right)
        let vertical = reverse(up) + [start] + reverse(down)

        let horizontalValid = validateWord(horizontal)
        let verticalValid = validateWord(vertical)

        for letter in horizontal {
            validateLetter(letter, validity: horizontalValid)
        }
        for letter in vertical {
            validateLetter(letter, validity: verticalValid)
        }
        validateLetter(start, validity: (horizontalValid && verticalValid) ||
                                        (horizontalValid && countElements(vertical) < 3) ||
                                        (verticalValid && countElements(horizontal) < 3))
    }

    private func validateLetter(letter: PlacedLetter, validity: Bool) {
        let adjacent = placedLetters[letter]!
        placedLetters[letter] = nil
        letter.valid = validity
        placedLetters[letter] = adjacent
    }

    private func getContinuousFrom(start: PlacedLetter, direction: (xDiff: Int, yDiff: Int), accumulator: [PlacedLetter]) -> [PlacedLetter]{
        let adjacents = placedLetters[start]!
        for adjacent in adjacents {
            if start.position.x + direction.xDiff == adjacent.position.x &&
                start.position.y + direction.yDiff == adjacent.position.y {
                    return getContinuousFrom(adjacent, direction: direction, accumulator: accumulator + [adjacent])
            }
        }
        return accumulator
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
            var adjacents = placedLetters[target]!
            placedLetters[target] = nil
            for adjacent in adjacents {
                placedLetters[adjacent] = placedLetters[adjacent]!.filter {
                    (letter) in letter != target
                }
            }
            if(placedLetters[target] != nil){
                adjacents = placedLetters[target]!
                for adjacent in adjacents {
                    validateFrom(adjacent)
                }
            }
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

    func validateWord(word: [PlacedLetter]) -> Bool {
        //assume that word is present in order given
        let term : String = word.map {
            (var letter) -> String in
            return letter.letter
        }.reduce("", +)
        return self.dictionary.search(term)
    }

    func description() -> String {
        var description = ""
        for letter in placedLetters.keys {
            description += letter.description() + "\n"
        }
        return description
    }
}