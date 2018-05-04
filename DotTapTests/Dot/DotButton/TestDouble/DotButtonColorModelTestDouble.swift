//
// Created by yokoyas000 on 2018/05/01.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import RxCocoa
@testable import DotTap

class DotButtonColorModelStub: DotButtonColorModelProtocol {

    private let replay: BehaviorRelay<DotButtonColorModelState>
    var didChange: RxCocoa.Driver<DotButtonColorModelState> {
        return self.replay.asDriver()
    }
    var currentState: DotButtonColorModelState {
        return self.replay.value
    }

    init(state: DotButtonColorModelState) {
        self.replay = BehaviorRelay<DotButtonColorModelState>(value: state)
    }

    func set(colors: Set<Color>, buttonCount: DotButtonCount) {}
}



class DotButtonColorModelSpy: DotButtonColorModelProtocol {

    enum CallArgs: Equatable {
        case currentState
        case set(colors: Set<Color>, buttonCount: DotButtonCount)

        static func == (lhs: DotButtonColorModelSpy.CallArgs, rhs: DotButtonColorModelSpy.CallArgs) -> Bool {
            switch (lhs, rhs) {
            case (.currentState, .currentState):
                return true
            case let (.set(colors: lcolors, buttonCount: lcount), .set(colors: rcolors, buttonCount: rcount)):
                return lcolors == rcolors
                    && lcount == rcount
            default:
                return false
            }
        }
    }



    private let replay: BehaviorRelay<DotButtonColorModelState>
    var callArgs: [CallArgs] = []
    var didChange: RxCocoa.Driver<DotButtonColorModelState> {
        return self.replay.asDriver()
    }
    var currentState: DotButtonColorModelState {
        self.callArgs.append(.currentState)
        return self.replay.value
    }

    init(state: DotButtonColorModelState = .notSet) {
        self.replay = BehaviorRelay<DotButtonColorModelState>(value: state)
    }

    func set(colors: Set<Color>, buttonCount: DotButtonCount) {
        self.callArgs.append(.set(colors: colors, buttonCount: buttonCount))
    }
}

