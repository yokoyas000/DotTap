//
//  DotButtonModel.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/25.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import RxCocoa
import RxSwift

class DotButtonModel: DotButtonModelProtocol {

    private let repository: ColorRepositoryProtocol
    private let replay: BehaviorRelay<DotButtonModelState>
    private let disposeBag = DisposeBag()

    var didChange: Driver<DotButtonModelState> {
        return self.replay.asDriver()
    }

    var currentState: DotButtonModelState {
        return self.replay.value
    }

    init(
        observe sheetModel: DotSheetModelProtocol,
        colorRepository: ColorRepositoryProtocol
    ) {
        self.repository = colorRepository
        self.replay = BehaviorRelay<DotButtonModelState>(value: [])

        sheetModel.didChange
            .drive(onNext: { [weak self] state in
                guard let this = self else { return }

                switch state {
                case .notCompare:
                    this.replay.accept(this.buttonColors())
                default:
                    break
                }
            })
            .disposed(by: self.disposeBag)
    }

    private func buttonColors() -> DotButtonModelColor {
        let colors = repository.colors
        var buttonColors: [Color] = colors

        let more = DotSheet.maxUsingColorCount - colors.count
        if more > 0 {
            for _ in colors.count ..< (colors.count + more) {
                let random = Int(arc4random_uniform(UInt32(colors.count)))
                buttonColors.append(colors[random])
            }
        }

        return buttonColors
    }
}
