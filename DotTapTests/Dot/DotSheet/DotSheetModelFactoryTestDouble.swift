//
//  DotSheetModelFactoryTestDouble.swift
//  DotTapTests
//
//  Created by yokoyas000 on 2018/04/26.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

@testable import DotTap

class DotSheetModelFactorySpy: DotSheetModelFactoryProtocol {

    enum CallArgs {
        case create(dotCount: Int, usingColors: Set<Color>)
    }

    init() {}

    private(set) var callArgs: [CallArgs] = []

    func create(dotCount: Int, usingColors: Set<Color>) -> DotSheetModelProtocol {
        self.callArgs.append(.create(dotCount: dotCount, usingColors: usingColors))
        return DotSheetModelStub(firstState: .hasNotCompared(dots: []))
    }
}

class DotSheetModelFactoryStub: DotSheetModelFactoryProtocol {

    private let firstModel: DotSheetModelProtocol
    private let secondModel: DotSheetModelProtocol
    private var createCount = 0

    init(
        firstModel: DotSheetModelProtocol,
        secondModel: DotSheetModelProtocol = DotSheetModelStub(firstState: .hasNotCompared(dots: []))
    ) {
        self.firstModel = firstModel
        self.secondModel = secondModel
    }

    func create(dotCount: Int, usingColors: Set<Color>) -> DotSheetModelProtocol {
        if self.createCount == 0 {
            self.createCount += 1
            return self.firstModel
        }

        return self.secondModel
    }
}
