//
//  ColorRepositoryTests.swift
//  DotTapTests
//
//  Created by yokoyas000 on 2018/04/26.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import XCTest
@testable import DotTap

class DotRepositoryTests: XCTestCase {

    struct TestCase {
        let min: Int
        let max: Int
    }

    func testColors() {
        let testCases: [UInt: TestCase] = [
            #line: TestCase(min: 2, max: 4),
            #line: TestCase(min: 3, max: 6),
            #line: TestCase(min: 4, max: 8),
        ]
        let repository = ColorRepository()

        testCases.forEach { (line, testCase) in
            let colors = repository.get(minCount: testCase.min, maxCount: testCase.max)

            let result = colors.count >= testCase.min
                && colors.count <= testCase.max
            XCTAssert(result, "colors.count: \(colors.count)")
        }

    }
}
