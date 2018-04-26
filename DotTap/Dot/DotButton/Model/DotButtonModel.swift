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
    typealias Dependency = (
        colorRepository: ColorRepositoryProtocol,
        buttonCountRepository: DotButtonCountRepositoryProtosol
    )

    private let dependency: Dependency
    private let relay: BehaviorRelay<DotButtonModelState>
    private let disposeBag = DisposeBag()

    var didChange: Driver<DotButtonModelState> {
        return self.relay.asDriver()
    }

    var currentButtons: DotButtonModelState.DotButtonState? {
        switch self.relay.value {
        case .notSet:
            return nil
        case let .reset(buttons: buttons), let .restart(buttons: buttons):
            return buttons
        }
    }

    init(
        dependency: Dependency,
        observe sheetModel: DotSheetModelProtocol
    ) {
        self.dependency = dependency
        self.relay = BehaviorRelay<DotButtonModelState>(value: .notSet)

        sheetModel.didChange
            .drive(onNext: { [weak self] state in
                guard let this = self else { return }

                switch state {
                case .notCompare:
                    this.relay.accept(
                        .reset(buttons: this.buttonState())
                    )
                default:
                    break
                }
            })
            .disposed(by: self.disposeBag)
    }

    func restart() {
        self.relay.accept(
            .restart(buttons: self.buttonState())
        )
    }

    private func buttonState() -> DotButtonModelState.DotButtonState {
        return DotButtonCountFactory.createDotButtonState(
            colors: self.dependency.colorRepository.colors,
            buttonCount: self.dependency.buttonCountRepository.count
        )
    }
}

extension DotButtonModel {

    enum DotButtonCountFactory {
        static func createDotButtonState(
            colors: [Color],
            buttonCount: DotButtonCount
        ) -> DotButtonModelState.DotButtonState {
            var buttonColors: [Color] = colors

            let more = buttonCount.rawValue - colors.count
            if more > 0 {
                for _ in colors.count ..< (colors.count + more) {
                    let random = Int(arc4random_uniform(UInt32(colors.count)))
                    buttonColors.append(colors[random])
                }
            }

            switch buttonCount {
            case .four:
                return DotButtonModelState.DotButtonState.four(
                    colors: DotButtonModelState.DotButtonFourColors(
                        one: buttonColors[0],
                        two: buttonColors[1],
                        three: buttonColors[2],
                        four: buttonColors[3]
                    )
                )
            case .six:
                return DotButtonModelState.DotButtonState.six(
                    colors: DotButtonModelState.DotButtonSixColors(
                        one: buttonColors[0],
                        two: buttonColors[1],
                        three: buttonColors[2],
                        four: buttonColors[3],
                        five: buttonColors[4],
                        six: buttonColors[5]
                    )
                )
            case .eight:
                return DotButtonModelState.DotButtonState.eight(
                    colors: DotButtonModelState.DotButtonEightColors(
                        one: buttonColors[0],
                        two: buttonColors[1],
                        three: buttonColors[2],
                        four: buttonColors[3],
                        five: buttonColors[4],
                        six: buttonColors[5],
                        seven: buttonColors[6],
                        eight: buttonColors[7]
                    )
                )
            }
        }
    }

}

