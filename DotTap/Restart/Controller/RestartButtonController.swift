//
// Created by yokoyas000 on 2018/05/01.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol RestartButtonControllerProtocol {}



class RestartButtonController: RestartButtonControllerProtocol {

    private let model: DotButtonModelProtocol
    private let disposeBag = DisposeBag()

    init(
        reactTo restartButton: UIButton,
        command model: DotButtonModelProtocol
    ) {
        self.model = model

        restartButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.model.reset()
            })
            .disposed(by: self.disposeBag)
    }
}
