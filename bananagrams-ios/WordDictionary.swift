//
//  Dictionary.swift
//  bananagrams-ios
//
//  Created by Zach Cotter on 12/23/14.
//  Copyright (c) 2014 Zach Cotter. All rights reserved.
//

import Foundation

class WordDictionary {
    
    var reader: TextReader
    
    init(){
        self.reader = TextReader(path: NSBundle.mainBundle().pathForResource("test_wordlist", ofType: "txt")!)
    }
    
    func search(term : String) -> Bool {
        for line in self.reader {
            if line == term {
                return true
            }
        }
        return false
    }
}