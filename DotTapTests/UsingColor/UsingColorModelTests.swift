//
// Created by yokoyas000 on 2018/05/01.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import XCTest
import RxCocoa
import RxBlocking
@testable import DotTap

class UsingColorModelTests: XCTestCase {

    // 確認: ColorRepository から値を取得していること
    // 状態: 初期化直後
    func testGetColorFromRepositoryWhenInitialize() {
        let expected: Set<Color> = [.lightBlue, .pink]
        let stubRepo = StubColorRepository(firstColors: expected)

        let usingColorModel = UsingColorModel(
            dependency: (
                colorRepository: stubRepo,
                buttonCountModel: StubDotButtonCountModel()
            )
        )

        let actual = try! usingColorModel
            .didChange
            .toBlocking()
            .first()!

        XCTAssertEqual(actual, expected)
    }

    // 確認: ColorRepository から値を取得していること
    // 状態: UsingColorModel#reset() の後
    func testGetColorFromRepositoryWhenReset() {
        let expected: Set<Color> = [.lightBlue, .pink]
        let stubRepo = StubColorRepository(
            firstColors: [.orange],
            secondColors: expected
        )

        let usingColorModel = UsingColorModel(
            dependency: (
                colorRepository: stubRepo,
                buttonCountModel: StubDotButtonCountModel()
            )
        )
        usingColorModel.reset()

        let actual = try! usingColorModel
            .didChange
            .toBlocking()
            .first()!

        XCTAssertEqual(actual, expected)
    }
}


