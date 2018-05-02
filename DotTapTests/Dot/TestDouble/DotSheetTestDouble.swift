//
//  DotSheetTestDouble.swift
//  DotTapTests
//
//  Created by yokoyas000 on 2018/04/26.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import RxCocoa
@testable import DotTap

class DotSheetModelStub: DotSheetModelProtocol {

    var didChange: Driver<DotSheetModelState> {
        return self.relay.asDriver()
    }
    var currentState: DotSheetModelState {
        return self.relay.value
    }

    private let relay: BehaviorRelay<DotSheetModelState>
    private let secondState: DotSheetModelState

    init(
        firstState: DotSheetModelState,
        secondState: DotSheetModelState = .hasNotCompared(dots: [])
    ) {
        self.relay = BehaviorRelay<DotSheetModelState>(
            value: firstState
        )
        self.secondState = secondState
    }

    func compare(color: Color) {
        self.relay.accept(self.secondState)
    }

}

class DotSheetModelSpy: DotSheetModelProtocol {

    enum CallArgs {
        case compare(color: Color)
    }

    var didChange: Driver<DotSheetModelState> {
        return BehaviorRelay<DotSheetModelState>(value: .hasNotCompared(dots: []))
            .asDriver()
    }

    var currentState: DotSheetModelState {
        return .hasNotCompared(dots: [])
    }

    private(set) var callArgs: [CallArgs] = []

    func compare(color: Color) {
        self.callArgs.append(.compare(color: color))
    }

}
