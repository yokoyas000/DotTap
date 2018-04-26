//
//  EightDotButtonsController.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/27.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import RxCocoa
import RxSwift

class EightDotButtonsController {

    private let sheetModel: DotSheetModelProtocol
    private let buttonModel: DotButtonModelProtocol
    private let disposeBag = DisposeBag()

    init(
        reactTo view: EightDotButtonsViewProtocol,
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

        view.button5.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                guard let colors = self?.colors() else {
                    return
                }
                self?.sheetModel.compare(color: colors.five)
            })
            .disposed(by: self.disposeBag)

        view.button6.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                guard let colors = self?.colors() else {
                    return
                }
                self?.sheetModel.compare(color: colors.six)
            })
            .disposed(by: self.disposeBag)

        view.button7.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                guard let colors = self?.colors() else {
                    return
                }
                self?.sheetModel.compare(color: colors.seven)
            })
            .disposed(by: self.disposeBag)

        view.button8.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                guard let colors = self?.colors() else {
                    return
                }
                self?.sheetModel.compare(color: colors.eight)
            })
            .disposed(by: self.disposeBag)
    }

    private func colors() -> DotButtonModelState.DotButtonEightColors? {
        if let current = self.buttonModel.currentButtons,
            case let .eight(colors: colors) = current {
            return colors
        }
        return nil
    }
}
