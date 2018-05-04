//
//  Created by yokoyas000 on 2018/05/02.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import RxSwift
import RxCocoa

protocol FourDotButtonsPassiveViewProtocol {
    var button1: DotButton { get }
    var button2: DotButton { get }
    var button3: DotButton { get }
    var button4: DotButton { get }
}



class FourDotButtonsPassiveView: FourDotButtonsPassiveViewProtocol {

    let button1: DotButton
    let button2: DotButton
    let button3: DotButton
    let button4: DotButton
    private let disposeBag = DisposeBag()

    init(
        views: (
            button1: DotButton,
            button2: DotButton,
            button3: DotButton,
            button4: DotButton
        ),
        observe model: DotButtonColorModelProtocol
    ) {
        self.button1 = views.button1
        self.button2 = views.button2
        self.button3 = views.button3
        self.button4 = views.button4

        model.didChange.drive(onNext: { [weak self] state in
            switch state {
            case let .didSet(.four(colors: colors)):
                self?.update(by: colors)
            case .notSet, .didSet(.six), .didSet(.eight):
                return
            }
        })
        .disposed(by: self.disposeBag)
    }

    private func update(by colors: DotButtonColorModelState.DotButtonFourColors) {
        self.button1.color = colors.one.value
        self.button2.color = colors.two.value
        self.button3.color = colors.three.value
        self.button4.color = colors.four.value
    }

}
