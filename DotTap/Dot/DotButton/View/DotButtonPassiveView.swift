//
//  DotButtonPassiveView.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/25.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import RxSwift
import RxCocoa

class DotButtonPassiveView {

    typealias Views = [DotButton]

    private let views: Views
    private let disposeBag = DisposeBag()

    init(
        update views: Views,
        observe model: DotButtonModelProtocol
    ) {
        self.views = views

        model.didChange
            .drive(onNext: { state in
                self.update(by: state)
            })
            .disposed(by: self.disposeBag)
    }

    private func update(by state: DotButtonModelState) {
        guard self.views.count == state.count else {
            return
        }

        state.enumerated().forEach { i, color in
            self.views[i].color = color.value
        }
    }
}
