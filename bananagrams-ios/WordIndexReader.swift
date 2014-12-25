//
//  WordIndexReader.swift
//  bananagrams-ios
//
//  Created by Zach Cotter on 12/24/14.
//  Copyright (c) 2014 Zach Cotter. All rights reserved.
//

import Foundation

class WordIndexReader : TextReader {

    init(path: String, depth: Int){
        var specialChunkSize = 4096
        super.init(path: path, chunkSize: specialChunkSize)
    }
}