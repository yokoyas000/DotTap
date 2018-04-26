//
//  SpyDotSheetTestDouble.swift
//  DotTapTests
//
//  Created by yokoyas000 on 2018/04/26.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import RxCocoa
@testable import DotTap

class StubDotSheetModel: DotSheetModelProtocol {

    var didChange: Driver<DotSheetModelState> {
        return self.replay.asDriver()
    }
    var currentState: DotSheetModelState {
        return self.replay.value
    }

    private let replay: BehaviorRelay<DotSheetModelState>
    private let secondState: DotSheetModelState

    init(
        firstState: DotSheetModelState,
        secondState: DotSheetModelState = .notCompare(dots: [])
        ) {
        self.replay = BehaviorRelay<DotSheetModelState>(
            value: firstState
        )
        self.secondState = secondState
    }

    func compare(color: Color) {
        self.replay.accept(self.secondState)
    }

}

class SpyDotSheetModel: DotSheetModelProtocol {

    enum CallArgs {
        case compare(color: Color)
    }

    var didChange: Driver<DotSheetModelState> {
        return BehaviorRelay<DotSheetModelState>(value: .notCompare(dots: []))
            .asDriver()
    }

    var currentState: DotSheetModelState {
        return .notCompare(dots: [])
    }

    private(set) var callArgs: [CallArgs] = []

    func compare(color: Color) {
        self.callArgs.append(.compare(color: color))
    }

}
