//
// Created by yokoyas000 on 2018/05/01.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import XCTest
import RxCocoa
import RxBlocking
@testable import DotTap

class DotButtonCountModelTests: XCTestCase {

    // 確認: Repository から値を取得していること
    // 状態: 初期化直
    func testGetCountFromRepositoryWhenInitialize() {
        let expected = DotButtonCount.six

        let stubRepo = DotButtonCountRepositoryStub(firstCount: expected)
        let buttonCountModel = DotButtonCountModel(
            dependency: stubRepo
        )

        let actual = try! buttonCountModel
            .didChange
            .toBlocking()
            .first()!

        XCTAssertEqual(actual, expected)
    }

    // 確認: Repository から値を取得していること
    // 状態: DotButtonCountModel#reset() の後
    func testGetCountFromRepositoryWhenReset() {
        let expected = DotButtonCount.six

        let stubRepo = DotButtonCountRepositoryStub(
            firstCount: .four,
            secondCount: expected
        )
        let buttonCountModel = DotButtonCountModel(
            dependency: stubRepo
        )
        buttonCountModel.reset()

        let actual = try! buttonCountModel
            .didChange
            .toBlocking()
            .first()!

        XCTAssertEqual(actual, expected)
    }
}