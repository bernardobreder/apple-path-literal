//
//  PathLiteralTests.swift
//  PathLiteral
//
//  Created by Bernardo Breder.
//
//

import XCTest
@testable import PathLiteralTests

extension PathLiteralTests {

	static var allTests : [(String, (PathLiteralTests) -> () throws -> Void)] {
		return [
			("testBools", testBools),
			("testCreateArray", testCreateArray),
			("testCreateDic", testCreateDic),
			("testDoubles", testDoubles),
			("testEncode", testEncode),
			("testInts", testInts),
			("testList", testList),
			("testResultOfFunc", testResultOfFunc),
			("testRoot", testRoot),
			("testStrings", testStrings),
			("testWord", testWord),
		]
	}

}

XCTMain([
	testCase(PathLiteralTests.allTests),
])

