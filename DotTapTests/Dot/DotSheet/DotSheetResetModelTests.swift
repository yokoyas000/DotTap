//
//  DotSheetResetModelTests.swift
//  DotTapTests
//
//  Created by yokoyas000 on 2018/04/26.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxBlocking
@testable import DotTap

class DotSheetResetModelTests: XCTestCase {

    enum TestValue {
        static let blueDot = ComparableDot(color: .blue, isDidMatch: false)
        static let pinkDot = ComparableDot(color: .pink, isDidMatch: false)
    }

    // 確認: 色の状態が流れてきたら、内部Modelを生成していること
    func testSetInnerModelWhenColorDidSet() {
        // 内部で生成される Model の状態
        let testState = DotSheetModelState.allDidMatch(dots: [TestValue.blueDot])
        let model = DotSheetResetModel(
            sheetModelFactory: DotSheetModelFactoryStub(
                firstModel: DotSheetModelStub(firstState: testState)
            ),
            bindTo: UsingColorModelStub(colors: [])
        )

        let expected = testState
        let actual = self.waitUntilAllDidMatch(model)

        XCTAssertEqual(actual, expected)
    }

    // 確認: 内部Modelの didChange が流れてくること
    func testDidChangeUsingInnerModel() {
        // 流れてくる予定の状態
        let testState = DotSheetModelState.allDidMatch(dots: [TestValue.blueDot])
        let model = DotSheetResetModel(
            sheetModelFactory: DotSheetModelFactoryStub(
                firstModel: DotSheetModelStub(
                    firstState: .compare(.match(dots: [TestValue.pinkDot])),
                    secondState: testState
                )
            ),
            bindTo: UsingColorModelStub(colors: [])
        )
        let expected = testState

        model.compare(color: .lightBlue)
        let actual = try! model.didChange.toBlocking().first()!

        XCTAssertEqual(actual, expected)
    }

    // 確認: 内部Modelの状態が .allDidMatch になった時、
    //      色の変更が行われること
    func testResetColorWhenAllCompared() {
        let sheetModelFactory = DotSheetModelFactoryStub(
            firstModel: DotSheetModelStub(
                firstState: .compare(.unmatch(dots: [])),
                secondState: .allDidMatch(dots: [])
            )
        )
        let spyColorModel = UsingColorModelSpy()

        let model = DotSheetResetModel(
            sheetModelFactory: sheetModelFactory,
            bindTo: spyColorModel
        )
        model.compare(color: .blue)
        
        _ = self.waitUntilAllDidMatch(model)

        XCTAssert(spyColorModel.callArgs.first! == .reset)
    }

    // 確認: 色を変更した後も内部Modelの didChange が流れてくること
    func testDidChangeAfterReset() {
        let testState = DotSheetModelState.allDidMatch(dots: [TestValue.pinkDot])
        let sheetModelFactory = DotSheetModelFactoryStub(
            firstModel: DotSheetModelStub(
                firstState: .compare(.unmatch(dots: [TestValue.blueDot])),
                secondState: .allDidMatch(dots: [TestValue.blueDot])
            ),
            secondModel: DotSheetModelStub(
                firstState: testState
            )
        )
        let expected = testState

        let model = DotSheetResetModel(
            sheetModelFactory: sheetModelFactory,
            bindTo: UsingColorModelStub(colors: [])
        )
        model.compare(color: .blue)
        _ = self.waitUntilAllDidMatch(model)

        let actual = try! model.didChange.toBlocking().first()!

        XCTAssertEqual(actual, expected)
    }

    private func waitUntilAllDidMatch(_ model: DotSheetModelProtocol) -> DotSheetModelState {
        return try! model.didChange
            .asObservable()
            .filter { state in
                self.isAllDidMatch(state)
            }
            .take(1)
            .toBlocking()
            .first()!
    }

    private func isAllDidMatch(_ state: DotSheetModelState) -> Bool {
        switch state {
        case .allDidMatch:
            return true
        default:
            return false
        }
    }
}
