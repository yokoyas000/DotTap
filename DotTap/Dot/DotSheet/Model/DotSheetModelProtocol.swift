//
//  DotSheetModelProtocol.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/25.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import RxCocoa

protocol DotSheetModelProtocol {
    var didChange: Driver<DotSheetModelState> { get }
    var currentState: DotSheetModelState { get }
    func compare(color: Color)
}

enum DotSheetModelState: Equatable {
    case notCompare(dots: [Dot])
    case compare(Compare)
    case allCompared(dots: [ComparableDot])

    static func == (lhs: DotSheetModelState, rhs: DotSheetModelState) -> Bool {
        switch (lhs, rhs) {
        case let (.notCompare(lDots), .notCompare(rDots)):
            return lDots == rDots
        case let (.allCompared(lDots), .allCompared(rDots)):
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
