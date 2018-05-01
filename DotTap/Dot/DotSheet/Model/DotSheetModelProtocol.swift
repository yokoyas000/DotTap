//
//  DotSheetModelProtocol.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/25.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import RxCocoa

/**
 状態遷移:

 [.hasNotCompared]
        |-- compare() --> [.compare(.match)]
        |                        |-- compare() --> [.compare(.match)]
        |                        |-- compare() --> [.compare(.unmatch)]
        |                        +-- compare() --> [.allDidMatch]
        |
        +-- compare() --> [.compare(.unmatch)]
                                 |-- compare() --> [.compare(.match)]
                                 +-- compare() --> [.compare(.unmatch)]
 **/
protocol DotSheetModelProtocol {
    var didChange: Driver<DotSheetModelState> { get }
    var currentState: DotSheetModelState { get }
    func compare(color: Color)
}

enum DotSheetModelState: Equatable {
    // 何も比較していない
    case hasNotCompared(dots: [Dot])
    // 比較した
    case compare(Compare)
    // 全て一致した
    case allDidMatch(dots: [ComparableDot])

    static func == (lhs: DotSheetModelState, rhs: DotSheetModelState) -> Bool {
        switch (lhs, rhs) {
        case let (.hasNotCompared(lDots), .hasNotCompared(rDots)):
            return lDots == rDots
        case let (.allDidMatch(lDots), .allDidMatch(rDots)):
            return lDots == rDots
        case let (.compare(lc), .compare(rc)):
            return lc == rc
        default:
            return false
        }
    }

    enum Compare: Equatable {
        case match(dots: [ComparableDot])
        case unmatch(dots: [ComparableDot])

        static func == (lhs: DotSheetModelState.Compare, rhs: DotSheetModelState.Compare) -> Bool {
            switch (lhs, rhs) {
            case let (.match(ldots), .match(rdots)):
                return ldots == rdots
            case let (.unmatch(ldots), .unmatch(rdots)):
                return ldots == rdots
            default:
                return false
            }
        }
    }
}
