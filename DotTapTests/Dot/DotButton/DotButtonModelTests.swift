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

    func testButtonColors() {
        let testColors: [Color] = [.lightBlue, .pink, .orange]
        let model = DotButtonModel(
            observe: StubDotSheetModel(firstState: .notCompare(dots: [])),
            colorRepository: StubColorRepository(colors: testColors)
        )

        let actualColors = try! model.didChange.toBlocking().first()!
        let unContainColors = testColors.filter { color in
            !actualColors.contains(color)
        }


        XCTAssert(unContainColors.count == 0)
    }
}
