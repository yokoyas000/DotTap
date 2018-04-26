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
        private(set) var comparableDots: [ComparableDot]

        init() {
            self.baseDots = [
                Dot(color: .lightBlue),
                Dot(color: .pink)
            ]
            self.comparableDots = self.baseDots.map { dot in
                ComparableDot(color: dot.color, isDidMatch: false)
            }
        }

        mutating func makeMatchComparableDots(index: Int) {
            self.comparableDots[index].isDidMatch = true
        }
    }

    func testInit() {
        let prepare = TestPrepare()
        let model = DotSheetModel(baseDots: prepare.baseDots)

        let expected = DotSheetModelState.notCompare(
            dots: prepare.baseDots
        )

        XCTAssertEqual(model.currentState, expected)
    }

    func testTransitCompareMatch() {
        var prepare = TestPrepare()
        let model = DotSheetModel(baseDots: prepare.baseDots)
        prepare.makeMatchComparableDots(index: 0)

        let expected = DotSheetModelState.compare(.match(dots: prepare.comparableDots))

        model.compare(color: prepare.baseDots.first!.color)
        let actual = try! model.didChange.toBlocking().first()!

        XCTAssertEqual(actual, expected)
    }

    func testTransitCompareUnmatch() {
        let prepare = TestPrepare()
        let model = DotSheetModel(baseDots: prepare.baseDots)

        let expected = DotSheetModelState.compare(.unmatch(dots: prepare.comparableDots))

        model.compare(color: .gray)
        let actual = try! model.didChange.toBlocking().first()!

        XCTAssertEqual(actual, expected)
    }

    func testTransitAllCompared() {
        var prepare = TestPrepare()
        let model = DotSheetModel(baseDots: prepare.baseDots)
        prepare.comparableDots.enumerated().forEach { (i, dot) in
            prepare.makeMatchComparableDots(index: i)
        }

        let expected = DotSheetModelState.allCompared(dots: prepare.comparableDots)

        prepare.baseDots.forEach { dot in
            model.compare(color: dot.color)
        }
        let actual = try! model.didChange.toBlocking().first()!

        XCTAssertEqual(actual, expected)
    }
}
