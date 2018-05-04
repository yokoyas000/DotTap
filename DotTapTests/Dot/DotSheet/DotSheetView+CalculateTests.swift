//
// Created by yokoyas000 on 2018/05/03.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import XCTest
@testable import DotTap

class DotSheetView_CalculateTests: XCTestCase {

    struct TestCase {
        let maxWidth: CGFloat
        let dotOneSideLength: Int
        let marginBetweenDots: Int
        let dotCount: Int
        let expected: (sheetWidth: CGFloat, dotRowCount: Int, dotColumnCount: Int)
    }

    func testCalculate() {
        let testCases: [UInt: TestCase] = [
            #line: TestCase(
                maxWidth: 200.0,
                dotOneSideLength: 10,
                marginBetweenDots: 10,
                dotCount: 10,
                expected: (
                    sheetWidth: 190.0,
                    dotRowCount: 1,
                    dotColumnCount: 10
                )
            ),
            #line: TestCase(
                maxWidth: 200.0,
                dotOneSideLength: 10,
                marginBetweenDots: 10,
                dotCount: 11,
                expected: (
                    sheetWidth: 200.0,
                    dotRowCount: 2,
                    dotColumnCount: 10
                )
            ),
        ]

        testCases.forEach { (line, testCase) in
            let actual = DotSheetView.Calculate.infoForConstraints(
                maxWidth: testCase.maxWidth,
                dotOneSideLength: testCase.dotOneSideLength,
                marginBetweenDots: testCase.marginBetweenDots,
                dotCount: testCase.dotCount
            )

            XCTAssertEqual(actual.sheetWidth, testCase.expected.sheetWidth, line: line)
            XCTAssertEqual(actual.dotRowCount, testCase.expected.dotRowCount, line: line)
            XCTAssertEqual(actual.dotColumnCount, testCase.expected.dotColumnCount, line: line)
        }
    }
}
