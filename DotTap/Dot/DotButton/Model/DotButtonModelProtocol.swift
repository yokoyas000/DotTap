//
//  DotButtonModelProtocol.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/26.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import RxSwift
import RxCocoa

protocol DotButtonModelProtocol {
    var didChange: Driver<DotButtonModelState> { get }
    var currentButtons: DotButtonModelState.DotButtonState? { get }

    func restart()
}

enum DotButtonModelState {
    case notSet
    case reset(buttons: DotButtonModelState.DotButtonState)
    case restart(buttons: DotButtonModelState.DotButtonState)

    enum DotButtonState {
        case four(colors: DotButtonFourColors)
        case six(colors: DotButtonSixColors)
        case eight(colors: DotButtonEightColors)
    }

    struct DotButtonFourColors {
        let one: Color
        let two: Color
        let three: Color
        let four: Color
    }

    struct DotButtonSixColors {
        let one: Color
        let two: Color
        let three: Color
        let four: Color
        let five: Color
        let six: Color
    }

    struct DotButtonEightColors {
        let one: Color
        let two: Color
        let three: Color
        let four: Color
        let five: Color
        let six: Color
        let seven: Color
        let eight: Color
    }
}
