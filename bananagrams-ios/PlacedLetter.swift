//
//  PlacedLetter.swift
//  bananagrams-ios
//
//  Created by Zach Cotter on 12/22/14.
//  Copyright (c) 2014 Zach Cotter. All rights reserved.
//

import Foundation

class PlacedLetter : Letter {
    var position: (x:Int, y:Int)
    
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
        super.init(letter: letter)
    }
    
    //TODO draw
}

func ==(left: PlacedLetter, right: PlacedLetter) -> Bool {
    return left.letter == right.letter &&
           left.position.x == right.position.x &&
           left.position.y == right.position.y
}

func !=(left: PlacedLetter, right: PlacedLetter) -> Bool {
    return left.letter != right.letter ||
        left.position.x != right.position.x
    ||
        left.position.y != right.position.y
}

