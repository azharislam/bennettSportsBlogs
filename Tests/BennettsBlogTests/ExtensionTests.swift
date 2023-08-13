//
//  UtilityTests.swift
//  BennettsBlogTests
//
//  Created by Azhar Islam on 13/08/2023.
//

import XCTest

final class ExtensionTests: XCTestCase {
    
    // MARK: - Array Extension Tests
    
    func testArrayChunked() {
        let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        
        let chunkedArray1 = array.chunked(into: 2)
        XCTAssertEqual(chunkedArray1, [[1, 2], [3, 4], [5, 6], [7, 8], [9, 10]])
        
        let chunkedArray2 = array.chunked(into: 3)
        XCTAssertEqual(chunkedArray2, [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10]])
        
        let chunkedArray3 = array.chunked(into: 20)
        XCTAssertEqual(chunkedArray3, [array])
    }
    
    // MARK: - String Extension Tests
    
    func testStringCapitalizingFirstLetter() {
        let string1 = "hello"
        XCTAssertEqual(string1.capitalizingFirstLetter(), "Hello")
        
        let string2 = "Hello"
        XCTAssertEqual(string2.capitalizingFirstLetter(), "Hello")
        
        let string3 = ""
        XCTAssertEqual(string3.capitalizingFirstLetter(), "")
        
        let string4 = "h"
        XCTAssertEqual(string4.capitalizingFirstLetter(), "H")
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}
