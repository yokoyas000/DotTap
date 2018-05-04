//
// Created by yokoyas000 on 2018/05/01.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import RxCocoa

class DotButtonCountModel: DotButtonCountModelProtocol {

    private let repository: DotButtonCountRepositoryProtocol
    private let relay: BehaviorRelay<DotButtonCountModelState>

    var didChange: Driver<DotButtonCountModelState> {
        return self.relay.asDriver()
    }

    var currentButtonCount: DotButtonCount {
        return self.relay.value
    }

    private(set) var currentState: DotButtonCountModelState {
        get {
            return self.relay.value
        }
        set {
            self.relay.accept(newValue)
        }
    }


    // - MARK: Initialize

    init(dependency repository: DotButtonCountRepositoryProtocol) {
        self.repository = repository

        let buttonCount = repository.get()
        self.relay = BehaviorRelay<DotButtonCountModelState>(value: buttonCount)
    }

    func reset() {
        self.currentState = self.repository.get()
    }

}
