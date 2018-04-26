//
//  DotSheetController.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/25.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import RxCocoa
import RxSwift

class DotSheetController {

    private let sheetModel: DotSheetModelProtocol
    private let buttonModel: DotButtonModelProtocol
    private let disposeBag = DisposeBag()

    typealias Views = (
        button1: DotButton,
        button2: DotButton,
        button3: DotButton,
        button4: DotButton
    )

    init(
        reactTo views: Views,
        depende buttonModel: DotButtonModelProtocol,
        command sheetModel: DotSheetModelProtocol
    ) {
        self.buttonModel = buttonModel
        self.sheetModel = sheetModel

        views.button1.rx.tap
            .asSignal()
            .emit(onNext: { [weak self] in
                guard let this = self else { return }
                this.sheetModel.compare(color: this.buttonModel.currentState[0])
            })
            .disposed(by: self.disposeBag)

        views.button2.rx.tap
            .asSignal()
            .emit(onNext: { [weak self] in
                guard let this = self else { return }
                this.sheetModel.compare(color: this.buttonModel.currentState[1])
            })
            .disposed(by: self.disposeBag)

        views.button3.rx.tap
            .asSignal()
            .emit(onNext: { [weak self] in
                guard let this = self else { return }
                this.sheetModel.compare(color: this.buttonModel.currentState[2])
            })
            .disposed(by: self.disposeBag)

        views.button4.rx.tap
            .asSignal()
            .emit(onNext: { [weak self] in
                guard let this = self else { return }
                this.sheetModel.compare(color: this.buttonModel.currentState[3])
            })
            .disposed(by: self.disposeBag)

    }
}
