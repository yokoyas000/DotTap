//
//  DotSheetPassiveView.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/25.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import RxCocoa
import RxSwift

class DotSheetPassiveView {

    private let sheetView: DotSheetView
    private var dotViews: [DotView] = []
    private let disposeBag = DisposeBag()

    init(
        update sheetView: DotSheetView,
        observe model: DotSheetModelProtocol
    ) {
        self.sheetView = sheetView

        model.didChange.drive(onNext: { [weak self] state in
            self?.update(by: state)
        })
        .disposed(by: self.disposeBag)
    }

    private func update(by state: DotSheetModelState) {
        switch state {
        case let .hasNotCompared(dots: dots):
            self.dotViews = DotViewFactory.create(dots: dots)
            self.sheetView.set(dotViews: self.dotViews)
        case let .compare(.match(dots: dots)):
            self.updateDotViews(dots: dots)
        case let .compare(.unmatch(dots: dots)):
            self.updateDotViews(dots: dots)
        case let .allDidMatch(dots: dots):
            self.updateDotViews(dots: dots)
        }
    }

    private func updateDotViews(dots: [ComparableDot]) {
        guard self.dotViews.count == dots.count else { return }
        dots.enumerated().forEach { i, dot in
            self.dotViews[i].color = dot.color.value
            if dot.isDidMatch {
                self.dotViews[i].color = Color.gray.value
            }
        }
    }
}
