//
//  Dictionary.swift
//  bananagrams-ios
//
//  Created by Zach Cotter on 12/23/14.
//  Copyright (c) 2014 Zach Cotter. All rights reserved.
//

import Foundation

class WordDictionary {
    
    let firstLetterIndexReader: TextReader
    let secondLetterIndexReader: TextReader
    let thirdLetterIndexReader: TextReader
    let wordlistReader: TextReader
    
    init(){
        let path : String = NSBundle.mainBundle().pathForResource("wordlist_filter_1", ofType: "txt")!
        self.firstLetterIndexReader = TextReader(path: path)
        self.secondLetterIndexReader = TextReader(path: NSBundle.mainBundle().pathForResource("wordlist_filter_2", ofType: "txt")!)
        self.thirdLetterIndexReader = TextReader(path: NSBundle.mainBundle().pathForResource("wordlist_filter_3", ofType: "txt")!)
        self.wordlistReader = TextReader(path: NSBundle.mainBundle().pathForResource("wordlist", ofType: "txt")!)
    }
    
    func search(term : String) -> Bool {
        
        let firstLetter = term.substringWithRange(Range(start: term.startIndex,
                                                        end: advance(term.startIndex, 1)))
        var nextIndex = NSNotFound
        
        for line in self.firstLetterIndexReader {
            if(line.hasPrefix(firstLetter)){
                nextIndex = line.componentsSeparatedByString(":")[1].toInt()!
                break
            }
        }
        
        if(nextIndex == NSNotFound){
            return false
        }
        
        let twoLetters = term.substringWithRange(Range(start: term.startIndex,
                                                       end: advance(term.startIndex, 2)))

        self.secondLetterIndexReader.jumpToChar(nextIndex)
        nextIndex = NSNotFound
        for line in self.secondLetterIndexReader{
            if(line.hasPrefix(twoLetters)){
                nextIndex = line.componentsSeparatedByString(":")[1].toInt()!
                break
            }
        }
        
        if(nextIndex == NSNotFound){
            return false;
        }
        
        let threeLetters = term.substringWithRange(Range(start: term.startIndex,
                                                         end: advance(term.startIndex, 3)))
        self.thirdLetterIndexReader.jumpToChar(nextIndex)
        nextIndex = NSNotFound
        for line in self.thirdLetterIndexReader{
            if(line.hasPrefix(threeLetters)){
                nextIndex = line.componentsSeparatedByString(":")[1].toInt()!
                break
            }
        }
        
        if(nextIndex == NSNotFound){
            return false
        }
        
        self.wordlistReader.jumpToChar(nextIndex)
        self.wordlistReader.nextLine()
        for line in self.wordlistReader{
            if(line.isEmpty || line.hasPrefix(threeLetters)){
                if(line == term && !line.isEmpty){
                    return true
                }
            }
            else{
                return false
            }
        }
        return false
    }
}