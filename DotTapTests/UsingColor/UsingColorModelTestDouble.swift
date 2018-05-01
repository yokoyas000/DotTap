//
// Created by yokoyas000 on 2018/05/01.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import RxCocoa
@testable import DotTap

class UsingColorModelStub: UsingColorModelProtocol {

    private let relay: BehaviorRelay<UsingColorModelState>

    var didChange: Driver<UsingColorModelState> {
        return self.relay.asDriver()
    }
    var currentState: UsingColorModelState {
        return self.relay.value
    }

    init(colors: Set<Color>) {
        self.relay = BehaviorRelay<UsingColorModelState>(value: colors)
    }

    func reset() {}
}



class UsingColorModelSpy: UsingColorModelProtocol {

    enum CallArgs {
        case currentState
        case reset
    }



    private let relay: BehaviorRelay<UsingColorModelState>
    var callArgs: [CallArgs] = []
    var didChange: Driver<UsingColorModelState> {
        return self.relay.asDriver()
    }
    var currentState: UsingColorModelState {
        self.callArgs.append(.currentState)
        return self.relay.value
    }

    init(colors: Set<Color> = []) {
        self.relay = BehaviorRelay<UsingColorModelState>(value: colors)
    }

    func reset() {
        self.callArgs.append(.reset)
    }
}