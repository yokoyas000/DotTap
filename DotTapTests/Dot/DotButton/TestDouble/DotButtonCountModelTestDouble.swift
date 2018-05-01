//
// Created by yokoyas000 on 2018/05/01.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import RxCocoa
@testable import DotTap

class DotButtonCountModelStub: DotButtonCountModelProtocol {

    private let replay: BehaviorRelay<DotButtonCountModelState>

    var didChange: RxCocoa.Driver<DotButtonCountModelState> {
        return self.replay.asDriver()
    }

    var currentState: DotButtonCountModelState {
        return self.replay.value
    }

    init(buttonCount: DotButtonCount) {
        self.replay = BehaviorRelay<DotButtonCountModelState>(value: buttonCount)
    }

    func reset() {}
}



class DotButtonCountModelSpy: DotButtonCountModelProtocol {

    enum CallArgs {
        case currentState
        case reset
    }



    private let relay: BehaviorRelay<DotButtonCountModelState>
    var callArgs: [CallArgs] = []
    var didChange: RxCocoa.Driver<DotButtonCountModelState> {
        return self.relay.asDriver()
    }
    var currentState: DotButtonCountModelState {
        self.callArgs.append(.currentState)
        return self.relay.value
    }

    init(state: DotButtonCountModelState = .four) {
        self.relay = BehaviorRelay<DotButtonCountModelState>(value: state)
    }

    func reset() {
        self.callArgs.append(.reset)
    }
}
