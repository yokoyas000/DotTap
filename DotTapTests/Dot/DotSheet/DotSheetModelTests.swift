//
//  DotSheetModelTests.swift
//  DotTapTests
//
//  Created by yokoyas000 on 2018/04/25.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import XCTest
import RxCocoa
import RxSwift
import RxBlocking
@testable import DotTap

class DotSheetModelTests: XCTestCase {
    struct TestPrepare {
        let baseDots: [Dot]
        var comparableDots: [ComparableDot]

        init(_ dotColors: [Color]) {
            self.baseDots = dotColors.map { color in
                Dot(color: color)
            }

            self.comparableDots = dotColors.map { color in
                ComparableDot(color: color, isDidMatch: false)
            }
        }
    }

    func testInit() {
        let prepare = TestPrepare([.lightBlue])
        let model = DotSheetModel(baseDots: prepare.baseDots)

        let expected = DotSheetModelState.hasNotCompared(
            dots: prepare.baseDots
        )

        XCTAssertEqual(model.currentState, expected)
    }

    // 確認: [.hasNotCompared] -- compare() --> [.compare(.match)]
    func testStateTransitionFromHasNotComparedToCompareMatch() {
        var prepare = TestPrepare([.lightBlue, .pink])
        let testIndex = 0
        prepare.comparableDots[testIndex].isDidMatch = true

        let expected = DotSheetModelState.compare(
            .match(dots: prepare.comparableDots)
        )

        let model = DotSheetModel(baseDots: prepare.baseDots)
        model.compare(color: prepare.baseDots[testIndex].color)
        let actual = try! model.didChange.toBlocking().first()!

        XCTAssertEqual(actual, expected)
    }

    // 確認: [.hasNotCompared] -- compare() --> [.compare(.unmatch)]
    func testStateTransitionFromHasNotComparedToCompareUnmatch() {
        let prepare = TestPrepare([.lightBlue, .pink])
        let expected = DotSheetModelState.compare(.unmatch(dots: prepare.comparableDots))

        let model = DotSheetModel(baseDots: prepare.baseDots)
        model.compare(color: .gray)
        let actual = try! model.didChange.toBlocking().first()!

        XCTAssertEqual(actual, expected)
    }

    // 確認: [.compare(.match)] -- compare() --> [.allDidMatch]
    func testTransitAllCompared() {
        var prepare = TestPrepare([.lightBlue, .pink])
        for i in 0 ..< prepare.comparableDots.count {
            prepare.comparableDots[i].isDidMatch = true
        }
        let expected = DotSheetModelState.allDidMatch(dots: prepare.comparableDots)

        let model = DotSheetModel(baseDots: prepare.baseDots)
        prepare.baseDots.forEach { dot in
            model.compare(color: dot.color)
        }
        let actual = try! model.didChange.toBlocking().first()!

        XCTAssertEqual(actual, expected)
    }
}
