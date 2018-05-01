//
// Created by yokoyas000 on 2018/05/01.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import RxCocoa

/**
 状態遷移:

 [.notSet]
    |
    +----> [.didSet]
                   |
                   +----> [.didSet]

 **/
protocol DotButtonColorModelProtocol {
    var didChange: Driver<DotButtonColorModelState> { get }
    var currentState: DotButtonColorModelState { get }
    func set(colors: Set<Color>, buttonCount: DotButtonCount)
}

enum DotButtonColorModelState {
    // 初期状態
    case notSet
    // ボタンの色が決定した時
    case didSet(color: DotButtonColorModelState.DotButtonColor)


    enum DotButtonColor {
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