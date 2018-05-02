//
//  DotButtonPassiveView.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/25.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa





class StubDotButtonView: FourDotButtonsPassiveViewProtocol, SixDotButtonsPassiveViewProtocol, EightDotButtonsPassiveViewProtocol {
    var button1: DotButton = DotButton()
    var button2: DotButton = DotButton()
    var button3: DotButton = DotButton()
    var button4: DotButton = DotButton()
    var button5: DotButton = DotButton()
    var button6: DotButton = DotButton()
    var button7: DotButton = DotButton()
    var button8: DotButton = DotButton()
}

protocol DotButtonFieldPassiveViewProtocol {}



class DotButtonFieldPassiveView: DotButtonFieldPassiveViewProtocol {

    typealias Views = (
        fourButtonsView: UIView,
        sixButtonsView: UIView,
        eightButtonsView: UIView
    )
    private let views: Views
    private let disposeBag = DisposeBag()

    init(
        update views: Views,
        observe buttonCountModel: DotButtonCountModelProtocol
    ) {
        self.views = views

        buttonCountModel.didChange
            .drive(onNext: { [weak self] state in
                self?.updateCount(by: state)
            })
            .disposed(by: self.disposeBag)
    }

    private func updateCount(by buttonState: DotButtonCountModelState) {
        // TODO: priority変更
        switch buttonState {
        case .four:
            return
        case .six:
            return
        case .eight:
            return
        }
    }

}
