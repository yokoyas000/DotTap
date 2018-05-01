//
// Created by yokoyas000 on 2018/05/01.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import RxCocoa

class DotButtonCountModel: DotButtonCountModelProtocol {

    private let repository: DotButtonCountRepositoryProtocol
    private let relay = BehaviorRelay<DotButtonCountModelState>(value: .notSet)

    var didChange: Driver<DotButtonCountModelState> {
        return self.relay.asDriver()
    }

    var currentButtonCount: DotButtonCount? {
        switch self.currentState {
        case .notSet:
            return nil
        case let .didSet(buttonCount: buttonCount):
            return buttonCount
        }
    }

    var currentState: DotButtonCountModelState {
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
        self.relay.accept(
            .didSet(buttonCount: self.repository.get())
        )
    }

    func reset() {
        self.relay.accept(
            .didSet(buttonCount: self.repository.get())
        )
    }

}
