//
// Created by yokoyas000 on 2018/05/01.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import XCTest
@testable import DotTap

class DotButtonColorFactoryTests: XCTestCase {

    struct TestCase {
        let colors: Set<Color>
        let count: DotButtonCount

        func isAllColorsContain(in buttonColors: DotButtonColorModelState.DotButtonFourColors) -> Bool {
            let containColors = self.colors.filter { color in
                if buttonColors.one == color
                       || buttonColors.two == color
                       || buttonColors.three == color
                       || buttonColors.four == color {
                    return true
                }
                return false
            }

            return self.colors.count == containColors.count
        }

        func isAllColorsContain(in buttonColors: DotButtonColorModelState.DotButtonSixColors) -> Bool {
            let containColors = self.colors.filter { color in
                if buttonColors.one == color
                       || buttonColors.two == color
                       || buttonColors.three == color
                       || buttonColors.four == color
                       || buttonColors.five == color
                       || buttonColors.six == color {
                    return true
                }
                return false
            }

            return self.colors.count == containColors.count
        }

        func isAllColorsContain(in buttonColors: DotButtonColorModelState.DotButtonEightColors) -> Bool {
            let containColors = self.colors.filter { color in
                if buttonColors.one == color
                       || buttonColors.two == color
                       || buttonColors.three == color
                       || buttonColors.four == color
                       || buttonColors.five == color
                       || buttonColors.six == color
                       || buttonColors.seven == color
                       || buttonColors.eight == color {
                    return true
                }
                return false
            }

            return self.colors.count == containColors.count
        }
    }

    func testCreateFourColors() {
        let testCases: [UInt: TestCase] = [
            #line: TestCase(
                colors: [.lightBlue, .pink],
                count: .four
            ),
            #line: TestCase(
                colors: [.lightBlue, .pink, .orange, .green],
                count: .four
            ),
        ]

        testCases.forEach { (line, testCase) in
            let buttonColor = DotButtonColorModel.DotButtonColorFactory.create(
                colors: testCase.colors,
                buttonCount: testCase.count
            )

            guard case let .four(colors:colors) = buttonColor else {
                XCTAssertFalse(true, line: line)
                return
            }

            XCTAssert(testCase.isAllColorsContain(in: colors))
        }
    }

    func testCreateSixColors() {
        let testCases: [UInt: TestCase] = [
            #line: TestCase(
                colors: [.lightBlue, .pink, .orange],
                count: .six
            ),
            #line: TestCase(
                colors: [.lightBlue, .pink, .orange, .green, .purple, .blue],
                count: .six
            ),
        ]

        testCases.forEach { (line, testCase) in
            let buttonColor = DotButtonColorModel.DotButtonColorFactory.create(
                colors: testCase.colors,
                buttonCount: testCase.count
            )

            guard case let .six(colors:colors) = buttonColor else {
                XCTAssertFalse(true, line: line)
                return
            }

            XCTAssert(testCase.isAllColorsContain(in: colors))
        }
    }

    func testCreateEightColors() {
        let testCases: [UInt: TestCase] = [
            #line: TestCase(
                colors: [.lightBlue, .pink, .orange, .green],
                count: .eight
            ),
            #line: TestCase(
                colors: [.lightBlue, .pink, .orange, .green, .purple, .blue, .turquoiseBlue, .lightGreen],
                count: .eight
            ),
        ]

        testCases.forEach { (line, testCase) in
            let buttonColor = DotButtonColorModel.DotButtonColorFactory.create(
                colors: testCase.colors,
                buttonCount: testCase.count
            )

            guard case let .eight(colors:colors) = buttonColor else {
                XCTAssertFalse(true, line: line)
                return
            }

            XCTAssert(testCase.isAllColorsContain(in: colors))
        }
    }

}