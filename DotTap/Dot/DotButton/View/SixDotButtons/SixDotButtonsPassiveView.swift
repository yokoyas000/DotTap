//
// Created by yokoyas000 on 2018/05/02.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import RxSwift
import RxCocoa

protocol SixDotButtonsPassiveViewProtocol {
    var button1: DotButton { get }
    var button2: DotButton { get }
    var button3: DotButton { get }
    var button4: DotButton { get }
    var button5: DotButton { get }
    var button6: DotButton { get }
}



class SixDotButtonsPassiveView: SixDotButtonsPassiveViewProtocol {

    let button1: DotButton
    let button2: DotButton
    let button3: DotButton
    let button4: DotButton
    let button5: DotButton
    let button6: DotButton
    private let disposeBag = DisposeBag()

    init(
        views: (
            button1: DotButton,
            button2: DotButton,
            button3: DotButton,
            button4: DotButton,
            button5: DotButton,
            button6: DotButton
        ),
        observe model: DotButtonColorModelProtocol
    ) {
        self.button1 = views.button1
        self.button2 = views.button2
        self.button3 = views.button3
        self.button4 = views.button4
        self.button5 = views.button5
        self.button6 = views.button6

        model.didChange.drive(onNext: { [weak self] state in
                switch state {
                case let .didSet(.six(colors: colors)):
                    self?.update(by: colors)
                case .notSet, .didSet(.four), .didSet(.eight):
                    return
                }
            })
            .disposed(by: self.disposeBag)
    }

    private func update(by colors: DotButtonColorModelState.DotButtonSixColors) {
        self.button1.color = colors.one.value
        self.button2.color = colors.two.value
        self.button3.color = colors.three.value
        self.button4.color = colors.four.value
        self.button5.color = colors.five.value
        self.button6.color = colors.six.value
    }

}
