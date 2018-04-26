//
//  DotSheetResetModelTests.swift
//  DotTapTests
//
//  Created by yokoyas000 on 2018/04/26.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import XCTest
import RxCocoa
@testable import DotTap

class DotSheetResetModelTests: XCTestCase {

    private let testInitState = DotSheetModelState.notCompare(
        dots: [Dot(color: .lightBlue)]
    )

    func testInitialize() {
        let sheetModelFactory = StubDotSheetModelFactory(
            firstModel: StubDotSheetModel(firstState: self.testInitState)
        )
        let expected = self.testInitState

        let model = DotSheetResetModel(
            dependency: (
                innerModelFactory: sheetModelFactory,
                colorRepository: StubColorRepository()
            )
        )
        let actual = model.currentState

        XCTAssertEqual(actual, expected)
    }

    // 確認: innerModel の didChange が流れてくること
    func testDidChangeUsingInnerModel() {
        let testState = DotSheetModelState.compare(.match(dots: []))
        let sheetModelFactory = StubDotSheetModelFactory(
            firstModel: StubDotSheetModel(
                firstState: self.testInitState,
                secondState: testState
            )
        )
        let expected = testState

        let model = DotSheetResetModel(
            dependency: (
                innerModelFactory: sheetModelFactory,
                colorRepository: StubColorRepository()
            )
        )
        model.compare(color: .lightBlue)
        let actual = try! model.didChange.toBlocking().first()!

        XCTAssertEqual(actual, expected)
    }

    // 確認: innerModel の状態が .allCompared になった時に innaerModel を再作成していること
    func testResetWhenAllCompared() {
        let testSheetModel = StubDotSheetModel(
            firstState: self.testInitState,
            secondState: .allCompared(dots: [])
        )
        let sheetModelFactory = SpyDotSheetModelFactory(
            sheetModel: testSheetModel,
            secondModel: StubDotSheetModel(firstState: self.testInitState)
        )

        let model = DotSheetResetModel(
            dependency: (
                innerModelFactory: sheetModelFactory,
                colorRepository: StubColorRepository()
            )
        )
        model.compare(color: .lightBlue)

        // init() と reset() で２回呼ばれているはず
        XCTAssertEqual(sheetModelFactory.callArgs.count, 2)
    }

    // 確認: reset() 後も didChange が流れてくること
    func testDidChangeAfterReset() {
        let testState = DotSheetModelState.compare(.match(dots: []))
        let sheetModelFactory = StubDotSheetModelFactory(
            firstModel: StubDotSheetModel(
                firstState: self.testInitState,
                secondState: .allCompared(dots: [])
            ),
            secondModel: StubDotSheetModel(
                firstState: testState
            )
        )
        let expected = testState

        let model = DotSheetResetModel(
            dependency: (
                innerModelFactory: sheetModelFactory,
                colorRepository: StubColorRepository()
            )
        )
        model.compare(color: .lightBlue)

        let actual = try! model.didChange.toBlocking().first()!

        XCTAssertEqual(actual, expected)
    }
}

class StubColorRepository: ColorRepositoryProtocol {
    private(set) var colors: [Color]

    init(colors: [Color] = []) {
        self.colors = colors
    }

    func resetColors() {}
}
