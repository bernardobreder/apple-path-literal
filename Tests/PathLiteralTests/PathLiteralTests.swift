//
//  PathLiteral.swift
//  PathLiteral
//
//  Created by Bernardo Breder on 20/01/17.
//
//

import XCTest
import Foundation
@testable import PathLiteral
@testable import Literal

class PathLiteralTests: XCTestCase {
    
    func testCreateDic() throws {
        let path = PathLiteral()
        path[["b"]] = "b"
        path[["a", "b", "c"]] = "d"
        path[["a", "b", "d"]] = 1
        path[["a", "b", "e"]] = 1.2
        path[["a", "b", "f"]] = true
        path[["a", "b", "g", "0"]] = "a"
        path[["a", "b", "g", "1"]] = true
        path[["a", "b", "g", "2"]] = 1.3
        
        XCTAssertEqual("b", path[["b"]]?.string)
        XCTAssertEqual("d", path[["a", "b", "c"]]?.string)
        XCTAssertEqual(1, path[["a", "b", "d"]]?.int)
        XCTAssertEqual(1.2, path[["a", "b", "e"]]?.double)
        XCTAssertEqual(true, path[["a", "b", "f"]]?.bool)
        XCTAssertEqual("a", path[["a", "b", "g", "0"]]?.string)
        XCTAssertEqual(true, path[["a", "b", "g", "1"]]?.bool)
        XCTAssertEqual(1.3, path[["a", "b", "g", "2"]]?.double)
        XCTAssertNil(path[["a", "b", "g", "2", "4"]]?.double)
        
        path[["b"]] = "B"
        path[["c"]] = nil
        path[["a", "b", "c"]] = "D"
        path[["a", "b", "d"]] = 11
        path[["a", "b", "e"]] = 1.3
        path[["a", "b", "f"]] = false
        path[["a", "b", "g", "0"]] = "A"
        path[["a", "b", "g", "1"]] = nil
        path[["a", "b", "g", "2"]] = 1.4
        
        XCTAssertEqual("B", path[["b"]]?.string)
        XCTAssertEqual("D", path[["a", "b", "c"]]?.string)
        XCTAssertEqual(11, path[["a", "b", "d"]]?.int)
        XCTAssertEqual(1.3, path[["a", "b", "e"]]?.double)
        XCTAssertEqual(false, path[["a", "b", "f"]]?.bool)
        XCTAssertEqual("A", path[["a", "b", "g", "0"]]?.string)
        XCTAssertNil(path[["a", "b", "g", "1"]]?.bool)
        XCTAssertEqual(1.4, path[["a", "b", "g", "2"]]?.double)
        XCTAssertNil(path[["a", "b", "g", "2", "4"]]?.double)
    }
    
    func testCreateArray() throws {
        do {
            let path = PathLiteral()
            path[["a", "0", "b"]] = "c"
            path[["a", "1", "d"]] = "e"
            XCTAssertEqual("c", path[["a", "0", "b"]]?.string)
            XCTAssertEqual("e", path[["a", "1", "d"]]?.string)
        }
        do {
            let path = PathLiteral()
            path[["a", "0"]] = "a"
            path[["a", "1"]] = "b"
            path[["a", "2"]] = "c"
            XCTAssertEqual("a", path[["a", "0"]]?.string)
            XCTAssertEqual("b", path[["a", "1"]]?.string)
            XCTAssertEqual("c", path[["a", "2"]]?.string)
        }
    }
    
    func testStrings() {
        let path = PathLiteral()
        path[["a", "0"]] = "a"
        path[["a", "1"]] = "b"
        path[["a", "2"]] = "c"
        XCTAssertEqual(["a", "b", "c"], path.strings("a"))
        XCTAssertEqual([], path.strings("a", "0"))
        XCTAssertEqual([], path.strings("a", "1"))
        XCTAssertEqual([], path.strings("a", "2"))
        XCTAssertEqual([], path.strings("a", "b", "3"))
    }
    
    func testInts() {
        let path = PathLiteral()
        path[["a", "0"]] = 1
        path[["a", "1"]] = 2
        path[["a", "2"]] = 3
        XCTAssertEqual([1, 2, 3], path.ints("a"))
        XCTAssertEqual([], path.strings("a", "0"))
        XCTAssertEqual([], path.strings("a", "1"))
        XCTAssertEqual([], path.strings("a", "2"))
        XCTAssertEqual([], path.strings("a", "b", "3"))
    }
    
    func testDoubles() {
        let path = PathLiteral()
        path[["a", "0"]] = 1.1
        path[["A", "1"]] = 2.2
        path[["a", "2"]] = 3.3
        XCTAssertEqual([1.1, 3.3], path.doubles("a"))
        XCTAssertEqual([2.2], path.doubles("A"))
        XCTAssertEqual([], path.strings("a", "0"))
        XCTAssertEqual([], path.strings("a", "1"))
        XCTAssertEqual([], path.strings("a", "2"))
        XCTAssertEqual([], path.strings("a", "b", "3"))
    }
    
    func testBools() {
        let path = PathLiteral()
        path[["a", "0"]] = true
        path[["a", "1"]] = false
        path[["a", "2"]] = true
        XCTAssertEqual([true, false, true], path.bools("a"))
        XCTAssertEqual([], path.strings("a", "0"))
        XCTAssertEqual([], path.strings("a", "1"))
        XCTAssertEqual([], path.strings("a", "2"))
        XCTAssertEqual([], path.strings("a", "b", "3"))
    }
    
    func testWord() {
        let path = PathLiteral()
        path[["a_"]] = true
        path[["a/b"]] = true
        path[["b$", "1"]] = false
        path[["a b", "2"]] = true
        XCTAssertNil(path[["a_"]]?.bool)
        XCTAssertNil(path[["b$"]]?.bool)
        XCTAssertNil(path[["a b"]]?.bool)
        XCTAssertNil(path[["a/b"]]?.bool)
    }
    
    func testRoot() {
        let path = PathLiteral()
        path[["0"]] = 1
        path[["2"]] = 2
        path[["4"]] = 3
        XCTAssertEqual(["0", "2", "4"], path.list())
    }

    func testResultOfFunc() {
        let path = PathLiteral()
        path[["a"]] = Literal(path.encode().isEmpty)
        XCTAssertEqual(false, path[["a"]]?.bool)
    }

    func testList() {
        let path = PathLiteral()
        path[["a", "b", "0"]] = true
        path[["a", "b", "2"]] = false
        path[["a", "b", "4"]] = true
        XCTAssertEqual([], path.list())
        XCTAssertEqual([], path.list("a"))
        XCTAssertEqual(["0", "2", "4"], path.list("a", "b"))
        XCTAssertEqual([], path.list("a", "b", "0"))
        XCTAssertEqual([], path.list("a", "b", "1"))
        XCTAssertEqual([], path.list("a", "b", "2"))
        XCTAssertEqual([], path.list("a", "b", "3"))
        XCTAssertEqual([], path.list("a", "b", "4"))
        XCTAssertEqual([], path.list("a", "b", "5"))
    }
    
    func testEncode() {
        var path = PathLiteral()
        path[["b"]] = "b"
        path[["a", "b", "c"]] = "d"
        path[["a", "b", "d"]] = 1
        path[["a", "b", "e"]] = 1.2
        path[["a", "b", "f"]] = true
        path[["a", "b", "g", "0"]] = "a"
        path[["a", "b", "g", "1"]] = true
        path[["a", "b", "g", "2"]] = 1.3
        
        XCTAssertEqual("b", path[["b"]]?.string)
        XCTAssertEqual("d", path[["a", "b", "c"]]?.string)
        XCTAssertEqual(1, path[["a", "b", "d"]]?.int)
        XCTAssertEqual(1.2, path[["a", "b", "e"]]?.double)
        XCTAssertEqual(true, path[["a", "b", "f"]]?.bool)
        XCTAssertEqual("a", path[["a", "b", "g", "0"]]?.string)
        XCTAssertEqual(true, path[["a", "b", "g", "1"]]?.bool)
        XCTAssertEqual(1.3, path[["a", "b", "g", "2"]]?.double)
        XCTAssertNil(path[["a", "b", "g", "2", "4"]]?.double)

        path = PathLiteral(string: path.encode())!
        
        XCTAssertEqual("b", path[["b"]]?.string)
        XCTAssertEqual("d", path[["a", "b", "c"]]?.string)
        XCTAssertEqual(1, path[["a", "b", "d"]]?.int)
        XCTAssertEqual(1.2, path[["a", "b", "e"]]?.double)
        XCTAssertEqual(true, path[["a", "b", "f"]]?.bool)
        XCTAssertEqual("a", path[["a", "b", "g", "0"]]?.string)
        XCTAssertEqual(true, path[["a", "b", "g", "1"]]?.bool)
        XCTAssertEqual(1.3, path[["a", "b", "g", "2"]]?.double)
        XCTAssertNil(path[["a", "b", "g", "2", "4"]]?.double)
    }
    
}

extension PathLiteral: Equatable {
    
    public static func ==(lhs: PathLiteral, rhs: PathLiteral) -> Bool {
        if lhs.chucks.count != rhs.chucks.count {
            if lhs.chucks.count > rhs.chucks.count {
                for i in rhs.chucks.count ..< lhs.chucks.count {
                    guard lhs.chucks[i].count == 0 else { return false }
                }
            } else {
                for i in lhs.chucks.count ..< rhs.chucks.count {
                    guard rhs.chucks[i].count == 0 else { return false }
                }
            }
        }
        for i in 0 ..< max(lhs.chucks.count, rhs.chucks.count) {
            guard lhs.chucks[i].count == rhs.chucks[i].count else { return false }
        }
        for i in 0 ..< max(lhs.chucks.count, rhs.chucks.count) {
            let lchuck = lhs.chucks[i]
            let rchuck = rhs.chucks[i]
            for u in 0 ..< lchuck.count {
                var found = false
                for o in 0 ..< rchuck.count {
                    if lchuck[u].hash == rchuck[o].hash && lchuck[u].path == rchuck[o].path {
                        found = true; break
                    }
                }
                guard found else { return false }
            }
        }
        return true
    }
    
}
