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
        buttonCountRepository: DotButtonCountRepositoryProtocol
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
        case let .resetColors(buttons: buttons),
             let .resetCount(buttons: buttons):
            return buttons
        }
    }

    init(
        dependency: Dependency,
        observe sheetModel: DotSheetModelProtocol
    ) {
        self.dependency = dependency
        self.relay = BehaviorRelay<DotButtonModelState>(value: .notSet)
        self.observe(sheetModel: sheetModel)
    }

    func restart(next sheetModel: DotSheetModelProtocol) {
        self.observe(sheetModel: sheetModel)

        // TODO: buttonRepository と colorRepository が reset されていることが前提となる
        //       Repository の reset, どこでやるべきか...
        self.relay.accept(.resetCount(buttons: self.buttonState()))
    }

    private func observe(sheetModel: DotSheetModelProtocol) {
        // DotButtonModelState が .hasNotCompared(初期状態) になった時、ボタンの色を変更する
        sheetModel.didChange
                .drive(onNext: { [weak self] state in
                    guard let this = self,
                          case let .hasNotCompared = state else {
                        return
                    }

                    this.relay.accept(
                            .resetColors(buttons: this.buttonState())
                    )
                })
                .disposed(by: self.disposeBag)
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

            // 色数がボタン数より少ない場合、同じ色のボタンを複数作る
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

