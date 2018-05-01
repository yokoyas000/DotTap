//
// Created by yokoyas000 on 2018/05/01.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import RxCocoa

/**
 状態遷移:

 [.notSet]
    |
    +-- reset() --> [.didSet(buttonCount:)]
                    |
                    +-- reset() --> [.didSet(buttonCount:)]
 **/
protocol DotButtonCountModelProtocol {
    var didChange: Driver<DotButtonCountModelState> { get }
    var currentCount: DotButtonCount? { get }

    func reset()
}

enum DotButtonCountModelState {
    // 初期状態
    case notSet
    // ボタンの数が決定した時
    case didSet(buttonCount: DotButtonCount)
}
