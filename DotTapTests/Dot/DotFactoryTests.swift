//
//  DotFactoryTests.swift
//  DotTapTests
//
//  Created by yokoyas000 on 2018/04/26.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import XCTest
import MirrorDiffKit
@testable import DotTap

class DotFactoryTests: XCTestCase {

    struct TestCase {
        let description: String
        let length: Int
        let colors: Set<Color>
    }

    func testCreate() {
        let testCases: [UInt: TestCase] = [
            #line: TestCase(
                description: "length = colors.count",
                length: 2,
                colors: [.lightBlue, .pink]
            ),
            #line: TestCase(
                description: "length > colors.count",
                length: 3,
                colors: [.lightBlue, .pink]
            ),
            #line: TestCase(
                description: "length < colors.count",
                length: 2,
                colors: [.lightBlue, .pink, .orange]
            ),
        ]

        testCases.forEach { (line, testCase) in
            let dots = DotFactory().create(
                count: testCase.length,
                usingColors: testCase.colors
            )
            let colors = NSOrderedSet(array: dots.map { $0.color })
                .array as! [Color]

            let unContainColors = colors.filter { color in
                !testCase.colors.contains(color)
            }
            let actual = (dots.count, unContainColors.count)
            let expected = (testCase.length, 0)

            XCTAssert(
                actual =~ expected,
                diff(between: actual, and: expected),
                line: line
            )
        }
    }

}
