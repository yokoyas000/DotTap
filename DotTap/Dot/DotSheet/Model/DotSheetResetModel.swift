//
//  DotSheetResetModel.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/25.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import RxCocoa
import RxSwift

class DotSheetResetModel: DotSheetModelProtocol {

    typealias Depandency = (
        innerModelFactory: DotSheetModelFactoryProtocol,
        colorRepository: ColorRepositoryProtocol
    )

    private let dependency: Depandency
    private var innerModel: DotSheetModelProtocol
    private let relay: BehaviorRelay<DotSheetModelState> = BehaviorRelay<DotSheetModelState>(value: .notCompare(dots: []))
    private let disposeBag = DisposeBag()

    var didChange: Driver<DotSheetModelState> {
        return self.relay.asDriver()
    }

    var currentState: DotSheetModelState {
        return self.relay.value
    }

    init(
        dependency: Depandency
    ) {
        self.dependency = dependency
        // FIXME: ランダムにするなら Repository 化
        let dotLength = DotSheet.buttonCount + 2
        self.innerModel = dependency.innerModelFactory.create(
            dotLength: dotLength,
            usingColors: dependency.colorRepository.colors
        )

        self.relay.subscribe(onNext: { [weak self] state in
            switch state {
            case .allCompared:
                self?.reset()
            default:
                break
            }
        })
        .disposed(by: self.disposeBag)

        self.innerModel.didChange
            .drive(self.relay)
            .disposed(by: self.disposeBag)
    }

    func compare(color: Color) {
        self.innerModel.compare(color: color)
    }

    private func reset() {
        let dotLength = DotSheet.buttonCount + 2
        self.innerModel = self.dependency.innerModelFactory.create(
            dotLength: dotLength,
            usingColors: dependency.colorRepository.colors
        )
        self.innerModel.didChange
            .drive(self.relay)
            .disposed(by: self.disposeBag)
    }
}
