//
// Created by yokoyas000 on 2018/04/29.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

@testable import DotTap

class StubColorRepository: ColorRepositoryProtocol {
    private let firstColors: Set<Color>
    private let secondColors: Set<Color>?
    private var calledCount = 0

    init(
        firstColors: Set<Color>,
        secondColors: Set<Color>? = nil
    ) {
        self.firstColors = firstColors
        self.secondColors = secondColors
    }

    func get(minCount: Int, maxCount: Int) -> Set<Color> {
        if calledCount == 0 {
            calledCount += 1
            return self.firstColors
        }

        return self.secondColors!
    }
}



class SpyColorRepository: ColorRepositoryProtocol {

    enum CallArgs {
        case get(minCount: Int, maxCount: Int)
    }

    private var callArgs: [CallArgs] = []

    init() {}

    func get(minCount: Int, maxCount: Int) -> Set<Color> {
        self.callArgs.append(.get(minCount: minCount, maxCount: maxCount))
        return []
    }
}