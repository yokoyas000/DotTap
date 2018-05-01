//
// Created by yokoyas000 on 2018/04/29.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

class DotButtonCountRepositoryStub: DotButtonCountRepositoryProtocol {
    private let firstCount: DotButtonCount
    private let secondCount: DotButtonCount?
    private var calledCount = 0

    init(
        firstCount: DotButtonCount,
        secondCount: DotButtonCount? = nil
    ) {
        self.firstCount = firstCount
        self.secondCount = secondCount
    }

    func get() -> DotButtonCount {
        if self.calledCount == 0 {
            self.calledCount += 1
            return self.firstCount
        }

        return self.secondCount!
    }
}
