//
//  DotButtonModelTests.swift
//  DotTapTests
//
//  Created by yokoyas000 on 2018/04/26.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import XCTest
import RxCocoa
@testable import DotTap

class DotButtonModelTests: XCTestCase {

    // 確認: 画面で使う色を変更した時にボタンの色も変わること
    func testButtonColorsWhenDidSetUsingColor() {
        let testButtonCount = DotButtonCount.four
        let testColor: Set<Color> = [.lightBlue, .pink, .orange]
        let spyButtonColorModel = DotButtonColorModelSpy()
        let expected = DotButtonColorModelSpy.CallArgs.set(colors: testColor, buttonCount: testButtonCount)

        let buttonModel = DotButtonModel(
            buttonCountModel: DotButtonCountModelStub(buttonCount: testButtonCount),
            buttonColorModel: spyButtonColorModel,
            usingColorModel: UsingColorModelStub(colors: testColor)
        )
        let actual = spyButtonColorModel.callArgs[0]

        XCTAssertEqual(actual, expected)
    }

    // 確認: DotButtonModel#reset() 時に ボタン数、使用色も変更されること
    func testReset() {
        let spyButtonCountModel = DotButtonCountModelSpy()
        let spyUsingColorModel = UsingColorModelSpy()

        let buttonModel = DotButtonModel(
            buttonCountModel: spyButtonCountModel,
            buttonColorModel: DotButtonColorModelStub(state: .notSet),
            usingColorModel: spyUsingColorModel
        )
        buttonModel.reset()

        let calledCount = spyButtonCountModel.callArgs
            .filter { call in
                call == DotButtonCountModelSpy.CallArgs.reset
            }
        let calledColor = spyUsingColorModel.callArgs
            .filter { call in
                call == UsingColorModelSpy.CallArgs.reset
            }

        XCTAssert(!calledCount.isEmpty && !calledColor.isEmpty)
    }
}
