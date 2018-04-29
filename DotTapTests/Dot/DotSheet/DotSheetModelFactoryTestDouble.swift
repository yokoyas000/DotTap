//
//  DotSheetModelFactoryTestDouble.swift
//  DotTapTests
//
//  Created by yokoyas000 on 2018/04/26.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

@testable import DotTap

class SpyDotSheetModelFactory: DotSheetModelFactoryProtocol {

    enum CallArgs {
        case create(dotLength: Int, usingColors: [Color])
    }

    private let sheetModel: DotSheetModelProtocol
    private let secondModel: DotSheetModelProtocol?

    init(
        sheetModel: DotSheetModelProtocol,
        secondModel: DotSheetModelProtocol?
    ) {
        self.sheetModel = sheetModel
        self.secondModel = secondModel
    }

    private(set) var callArgs: [CallArgs] = []

    func create(dotLength: Int, usingColors: [Color]) -> DotSheetModelProtocol {
        self.callArgs.append(.create(dotLength: dotLength, usingColors: usingColors))

        if self.callArgs.count == 2, let secondModel = self.secondModel {
            return secondModel
        }
        return self.sheetModel
    }
}

class StubDotSheetModelFactory: DotSheetModelFactoryProtocol {

    private let firstModel: DotSheetModelProtocol
    private let secondModel: DotSheetModelProtocol
    private var createCount = 0

    init(
        firstModel: DotSheetModelProtocol,
        secondModel: DotSheetModelProtocol = StubDotSheetModel(firstState: .hasNotCompared(dots: []))
        ) {
        self.firstModel = firstModel
        self.secondModel = secondModel
    }

    func create(dotLength: Int, usingColors: [Color]) -> DotSheetModelProtocol {
        if self.createCount == 0 {
            self.createCount += 1
            return self.firstModel
        }

        return self.secondModel
    }
}
