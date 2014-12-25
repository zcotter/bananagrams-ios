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
}