//
//  DotSheetResetModel.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/25.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import RxCocoa
import RxSwift

protocol DotSheetResetModelProtocol: DotSheetModelProtocol {}

class DotSheetResetModel: DotSheetResetModelProtocol {

    private let dotCountRepository: DotCountRepositoryProtocol
    private let innerModelFactory: DotSheetModelFactoryProtocol
    private let colorModel: UsingColorModelProtocol
    private var innerModel: DotSheetModelProtocol? = nil
    private let relay: BehaviorRelay<DotSheetModelState>
        = BehaviorRelay<DotSheetModelState>(value: .hasNotCompared(dots: []))
    private let disposeBag = DisposeBag()

    var didChange: Driver<DotSheetModelState> {
        return self.relay.asDriver()
    }

    var currentState: DotSheetModelState {
        return self.relay.value
    }

    init(
        sheetModelFactory: DotSheetModelFactoryProtocol,
        dotCountRepository: DotCountRepositoryProtocol,
        bindTo colorModel: UsingColorModelProtocol
    ) {
        self.dotCountRepository = dotCountRepository
        self.innerModelFactory = sheetModelFactory
        self.colorModel = colorModel

        self.colorModel
            .didChange.drive(onNext: { [weak self] colors in
                self?.setInnerModel(colors: colors)
            })
            .disposed(by: self.disposeBag)

        self.relay
            .subscribe(onNext: { [weak self] state in
                guard case .allDidMatch = state else { return }
                self?.colorModel.reset()
            })
            .disposed(by: self.disposeBag)
    }

    func compare(color: Color) {
        self.innerModel?.compare(color: color)
    }

    private func setInnerModel(colors: Set<Color>) {
        let dotLength = self.dotCountRepository.get(
            minCount: colors.count,
            maxCount: colors.count + 2
        )
        self.innerModel = self.innerModelFactory.create(
            dotCount: dotLength,
            usingColors: colors
        )
        self.innerModel?.didChange
            .drive(self.relay)
            .disposed(by: self.disposeBag)
    }

}
