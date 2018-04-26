//
//  FourDotButtonsController.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/27.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import RxCocoa
import RxSwift

class FourDotButtonsController {

    private let sheetModel: DotSheetModelProtocol
    private let buttonModel: DotButtonModelProtocol
    private let disposeBag = DisposeBag()

    init(
        reactTo view: FourDotButtonsViewProtocol,
        depende buttonModel: DotButtonModelProtocol,
        command sheetModel: DotSheetModelProtocol
        ) {
        self.sheetModel = sheetModel
        self.buttonModel = buttonModel

        view.button1.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                guard let colors = self?.colors() else {
                    return
                }
                self?.sheetModel.compare(color: colors.one)
            })
            .disposed(by: self.disposeBag)

        view.button2.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                guard let colors = self?.colors() else {
                    return
                }
                self?.sheetModel.compare(color: colors.two)
            })
            .disposed(by: self.disposeBag)

        view.button3.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                guard let colors = self?.colors() else {
                    return
                }
                self?.sheetModel.compare(color: colors.three)
            })
            .disposed(by: self.disposeBag)

        view.button4.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                guard let colors = self?.colors() else {
                    return
                }
                self?.sheetModel.compare(color: colors.four)
            })
            .disposed(by: self.disposeBag)
    }

    private func colors() -> DotButtonModelState.DotButtonFourColors? {
        if case let .four(colors: colors) = self.buttonModel.currentButtons {
            return colors
        }
        return nil
    }
}
