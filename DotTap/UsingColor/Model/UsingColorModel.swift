//
// Created by yokoyas000 on 2018/04/30.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import RxCocoa

class UsingColorModel: UsingColorModelProtocol {

    typealias Dependency = (
        colorRepository: ColorRepositoryProtocol,
        buttonCountModel: DotButtonCountModelProtocol
    )

    private let dependency: Dependency
    private let relay: BehaviorRelay<UsingColorModelState>

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

    init(
        dependency: Dependency
    ) {
        self.dependency = dependency

        let buttonCount = dependency.buttonCountModel.currentState
        let state = dependency.colorRepository.get(
            minCount: ColorCountFactory.createMinCount(maxCount: buttonCount.rawValue),
            maxCount: buttonCount.rawValue
        )
        self.relay = BehaviorRelay<UsingColorModelState>(value: state)
    }

    func reset() {
        let buttonCount = self.dependency.buttonCountModel.currentState
        self.currentState = self.dependency.colorRepository.get(
            minCount: ColorCountFactory.createMinCount(maxCount: buttonCount.rawValue),
            maxCount: buttonCount.rawValue
        )
    }

}

extension UsingColorModel {
    enum ColorCountFactory {
        static func createMinCount(maxCount: Int) -> Int {
            if maxCount <= 4 {
                return 4
            }
            return maxCount - 2
        }
    }
}
