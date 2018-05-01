//
// Created by yokoyas000 on 2018/04/30.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import RxCocoa

class UsingColorModel: UsingColorModelProtocol {

    private let colorRepository: ColorRepositoryProtocol
    private let relay = BehaviorRelay<UsingColorModelState>(value: .notSet)

    var didChange: Driver<UsingColorModelState> {
        return self.relay.asDriver()
    }

    var currentState: UsingColorModelState {
        get {
            return self.relay.value
        }
        set {
            self.relay.accept(newValue)
        }
    }


    // - MARK: Initialize

    init(dependency colorRepository: ColorRepositoryProtocol) {
        self.colorRepository = colorRepository
    }

    func set(useTo buttonCount: DotButtonCount) {
        let colors = self.colorRepository.get(
            minCount: buttonCount.rawValue / 2,
            maxCount: buttonCount.rawValue
        )

        self.currentState = .didSet(
            usingColors: colors
        )
    }

}