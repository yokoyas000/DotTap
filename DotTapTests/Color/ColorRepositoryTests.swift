//
//  ColorRepositoryTests.swift
//  DotTapTests
//
//  Created by yokoyas000 on 2018/04/26.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import XCTest
@testable import DotTap

class DotRepositoryTests: XCTestCase {

    func testColors() {
        let minColorCount = 2
        let maxColorCount = 4
        let repository = ColorRepository(
            minCount: minColorCount,
            maxCount: maxColorCount
        )

        for _ in 0..<10 {
            repository.resetColors(minCount: 2, maxCount: 4)

            let result = repository.colors.count >= minColorCount
                && repository.colors.count <= maxColorCount
            XCTAssert(result, "colors.count: \(repository.colors.count)")
        }

    }
}
