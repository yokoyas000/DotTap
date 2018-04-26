//
//  DotSheetController.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/25.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import RxCocoa
import RxSwift

class DotButtonController {

    private let sheetModel: DotSheetModelProtocol
    private let buttonModel: DotButtonModelProtocol
    private let disposeBag = DisposeBag()

    typealias Events = [Signal<Void>]

    init(
        reactTo events: Events,
        depende buttonModel: DotButtonModelProtocol,
        command sheetModel: DotSheetModelProtocol
    ) {
        self.buttonModel = buttonModel
        self.sheetModel = sheetModel

        guard events.count == buttonModel.currentState.count else {
            return
        }
        events.enumerated().forEach { i, event in
            event.emit(onNext: { [weak self] in
                guard let this = self else { return }
                this.sheetModel.compare(color: this.buttonModel.currentState[i])
            })
            .disposed(by: self.disposeBag)
        }
    }
}
