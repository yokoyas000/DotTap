//
//  DotButtonPassiveView.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/25.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import RxSwift
import RxCocoa

protocol FourDotButtonsViewProtocol {
    var button1: DotButton { get set }
    var button2: DotButton { get set }
    var button3: DotButton { get set }
    var button4: DotButton { get set }
}

protocol SixDotButtonsViewProtocol {
    var button1: DotButton { get set }
    var button2: DotButton { get set }
    var button3: DotButton { get set }
    var button4: DotButton { get set }
    var button5: DotButton { get set }
    var button6: DotButton { get set }
}

protocol EightDotButtonsViewProtocol {
    var button1: DotButton { get set }
    var button2: DotButton { get set }
    var button3: DotButton { get set }
    var button4: DotButton { get set }
    var button5: DotButton { get set }
    var button6: DotButton { get set }
    var button7: DotButton { get set }
    var button8: DotButton { get set }
}

class DotButtonPassiveView {

    typealias Views = (
        fourButtonsView: FourDotButtonsViewProtocol,
        sixButtonsView: SixDotButtonsViewProtocol,
        eightButtonsView: EightDotButtonsViewProtocol
    )
    private let views: Views
    private let disposeBag = DisposeBag()

    init(
        update views: Views,
        observe model: DotButtonModelProtocol
    ) {
        self.views = views

        model.didChange
            .drive(onNext: { [weak self] state in
                self?.update(by: state)
            })
            .disposed(by: self.disposeBag)
    }

    private func update(by state: DotButtonModelState) {
        switch state {
        case .notSet:
            return
        case let .reset(buttons: buttons):
            self.reset(by: buttons)
        case let .restart(buttons: buttons):
            self.restart(by: buttons)
        }

    }

    private func reset(by buttonState: DotButtonModelState.DotButtonState) {
        switch buttonState {
        case let .four(colors: colors):
            self.updateFourButtons(colors: colors)
        case let .six(colors: colors):
            self.updateSixButtons(colors: colors)
        case let .eight(colors: colors):
            self.updateEightButtons(colors: colors)
        }
    }

    private func restart(by buttonState: DotButtonModelState.DotButtonState) {
        // TODO: priorityの変更
        switch buttonState {
        case let .four(colors: colors):
            self.updateFourButtons(colors: colors)
        case let .six(colors: colors):
            self.updateSixButtons(colors: colors)
        case let .eight(colors: colors):
            self.updateEightButtons(colors: colors)
        }
    }

    private func updateFourButtons(colors: DotButtonModelState.DotButtonFourColors) {
        self.views.fourButtonsView.button1.color = colors.one.value
        self.views.fourButtonsView.button2.color = colors.two.value
        self.views.fourButtonsView.button3.color = colors.three.value
        self.views.fourButtonsView.button4.color = colors.four.value
    }

    private func updateSixButtons(colors: DotButtonModelState.DotButtonSixColors) {}

    private func updateEightButtons(colors: DotButtonModelState.DotButtonEightColors) {}

}
