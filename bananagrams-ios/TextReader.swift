import Foundation

class TextReader {
    let encoding : UInt
    let chunkSize : Int
    
    var fileHandle : NSFileHandle!
    let buffer : NSMutableData!
    let delimiter : NSData!
    var reachedEnd : Bool = false
    
    init(path: String,
          encoding : UInt = NSUTF8StringEncoding,
          chunkSize : Int = 4096){
        
        self.chunkSize = chunkSize
        self.encoding = encoding
        self.fileHandle = NSFileHandle(forReadingAtPath: path)
        self.delimiter = "\n".dataUsingEncoding(NSUTF8StringEncoding)
        self.buffer = NSMutableData(capacity: chunkSize)
    }
    
    deinit {
        self.close()
    }
    
    /// Return next line, or nil on EOF.
    func nextLine() -> String? {
        if reachedEnd {
            return nil
        }
        
        // Read data chunks from file until a line delimiter is found:
        var range = buffer.rangeOfData(delimiter,
                                       options: nil,
                                       range: NSMakeRange(0, buffer.length))
        while range.location == NSNotFound {
            var tempData = fileHandle.readDataOfLength(chunkSize)
            if tempData.length == 0 {
                reachedEnd = true
                if buffer.length > 0 {
                    let line = NSString(data: buffer, encoding: encoding);
                    buffer.length = 0
                    return line
                }
                return nil
            }
            buffer.appendData(tempData)
            range = buffer.rangeOfData(delimiter,
                                       options: nil,
                                       range: NSMakeRange(0, buffer.length))
        }
        
        // Convert complete line (excluding the delimiter) to a string:
        let line = NSString(data: buffer.subdataWithRange(NSMakeRange(0, range.location)),
            encoding: encoding)
        // Remove line (and the delimiter) from the buffer:
        buffer.replaceBytesInRange(NSMakeRange(0, range.location + range.length), withBytes: nil, length: 0)
        
        return line
    }
    
    /// Start reading from the beginning of file.
    func rewind() -> Void {
        fileHandle.seekToFileOffset(0)
        buffer.length = 0
        reachedEnd = false
    }
    
    func jumpToByte(location : UInt64){
        fileHandle.seekToFileOffset(location)
        buffer.length = Int(location)
        reachedEnd = false
    }
    
    func jumpToChar(location: Int){
        jumpToByte(UInt64(location))
    }
    
    /// Close the underlying file. No reading must be done after calling this method.
    func close() -> Void {
        if fileHandle != nil {
            fileHandle.closeFile()
            fileHandle = nil
        }
    }
}

extension TextReader : SequenceType {
    func generate() -> GeneratorOf<String> {
        return GeneratorOf<String> {
            return self.nextLine()
        }
    }
}