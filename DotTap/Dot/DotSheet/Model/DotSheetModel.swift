//
//  DotSheetModel.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/25.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import RxCocoa

class DotSheetModel: DotSheetModelProtocol {
    private let baseDots: [Dot]
    private var comparableDots: [ComparableDot] = []
    private let relay: BehaviorRelay<DotSheetModelState>

    var didChange: Driver<DotSheetModelState> {
        return self.relay.asDriver()
    }

    var currentState: DotSheetModelState {
        return self.relay.value
    }

    init(baseDots: [Dot]) {
        self.baseDots = baseDots
        self.comparableDots = baseDots.map { dot in
            return ComparableDot(color: dot.color, isDidMatch: false)
        }

        self.relay = BehaviorRelay<DotSheetModelState>(
            value: .hasNotCompared(dots: self.baseDots)
        )
    }

    func compare(color: Color) {
        let i = self.comparableDots.index { $0.isDidMatch == false }
        guard let index = i else {
            return
        }

        self.comparableDots[index].color == color
            ? match(index: index)
            : unmatch()
    }

    private func match(index: Int) {
        self.comparableDots[index].isDidMatch = true

        if index == self.comparableDots.endIndex - 1 {
            self.relay.accept(
                .allDidMatch(dots: self.comparableDots)
            )
        } else {
            self.relay.accept(
                .compare(.match(dots: self.comparableDots))
            )
        }

    }

    private func unmatch() {
        self.relay.accept(
            .compare(.unmatch(dots: self.comparableDots))
        )
    }

}
