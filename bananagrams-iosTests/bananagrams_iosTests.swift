//
//  bananagrams_iosTests.swift
//  bananagrams-iosTests
//
//  Created by Zach Cotter on 12/24/14.
//  Copyright (c) 2014 Zach Cotter. All rights reserved.
//

import UIKit
import XCTest
import bananagrams_ios

class bananagrams_iosTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDictionary() {
        let dict = WordDictionary()
        XCTAssert(dict.search("apple") == true, "Find word")
        XCTAssert(dict.search("notaword") == false, "find fake")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
