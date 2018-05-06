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
        let expected: DotSheetView.ConstraintsInfo

        static func dotViews(count: Int) -> [DotView] {
            var dotViews: [DotView] = []
            for _ in 0 ..< count {
                dotViews.append(DotView())
            }

            return dotViews
        }
    }

    func testCalculate() {
        let testCases: [UInt: TestCase] = [
            #line: TestCase(
                maxWidth: 200.0,
                dotOneSideLength: 10,
                marginBetweenDots: 10,
                dotCount: 10,
                expected: DotSheetView.ConstraintsInfo(
                    sheetWidth: 190.0,
                    dotColumnCount: 10,
                    dotRows: [TestCase.dotViews(count: 10)]
                )
            ),
            #line: TestCase(
                maxWidth: 200.0,
                dotOneSideLength: 10,
                marginBetweenDots: 10,
                dotCount: 11,
                expected: DotSheetView.ConstraintsInfo(
                    sheetWidth: 200.0,
                    dotColumnCount: 10,
                    dotRows: [
                        TestCase.dotViews(count: 10),
                        TestCase.dotViews(count: 1)
                    ]
                )
            ),
        ]

        testCases.forEach { (line, testCase) in
            let actual = DotSheetView.Calculate.constraintsInfo(
                maxWidth: testCase.maxWidth,
                dotOneSideLength: testCase.dotOneSideLength,
                marginBetweenDots: testCase.marginBetweenDots,
                dotViews: TestCase.dotViews(count: testCase.dotCount)
            )

            XCTAssertEqual(testCase.expected.dotRows.count, actual.dotRows.count, line: line)
            XCTAssertEqual(testCase.expected.dotColumnCount, actual.dotColumnCount, line: line)
            XCTAssertEqual(testCase.expected.sheetWidth, actual.sheetWidth, line: line)
        }
    }
}
