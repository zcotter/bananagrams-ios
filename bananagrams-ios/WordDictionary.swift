import Foundation

class WordDictionary {
    
    let indexReaders: [TextReader]
    let wordlistReader: TextReader
    
    init(){
        indexReaders = []
        for depth in 1...3 {
            let path = NSBundle.mainBundle().pathForResource("wordlist_filter_\(depth)", ofType: "txt")!
            self.indexReaders.append(TextReader(path: path))
        }
        self.wordlistReader = TextReader(path: NSBundle.mainBundle().pathForResource("wordlist", ofType: "txt")!)
    }
    
    private func rewindAll(){
        for reader in indexReaders{
            reader.rewind()
        }
        self.wordlistReader.rewind()
    }
    
    private func findNextIndex(depth: Int, prefix: String, startIndex: Int) -> Int {
        var reader = self.indexReaders[depth]
        reader.jumpToChar(startIndex)
        for line in reader {
            if(line.hasPrefix(prefix)){
                return line.componentsSeparatedByString(":")[1].toInt()!
            }
        }
        return NSNotFound
    }
    
    private func findStartPositionFromIndexes(term: String) -> Int {
        var nextIndex = 0
        for depth in 1...3 {
            let prefix = term.substringWithRange(Range(start: term.startIndex,
                end: advance(term.startIndex,
                    depth)))
            nextIndex = findNextIndex(depth - 1, prefix: prefix, startIndex: nextIndex)
            if(nextIndex == NSNotFound){
                return NSNotFound
            }
        }
        return nextIndex
    }
    
    func search(term : String) -> Bool {
        if(countElements(term) < 3){
            return false
        }
        rewindAll()
        var term = term.lowercaseString
        var startIndex = findStartPositionFromIndexes(term)
        
        if startIndex == NSNotFound {
            return false
        }
        
        let threeLetters = term.substringWithRange(Range(start: term.startIndex,
                                                         end: advance(term.startIndex,
                                                                      3)))
        self.wordlistReader.jumpToChar(startIndex)
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