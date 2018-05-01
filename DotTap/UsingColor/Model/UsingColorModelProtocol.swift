//
// Created by yokoyas000 on 2018/04/29.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import RxCocoa


/**
 状態遷移:

 [.notSet]
     |
     +-- set() --> [.didSet]
                       |
                       +-- set() --> [.didSet]

 **/
protocol UsingColorModelProtocol {
    var didChange: Driver<UsingColorModelState> { get }
    func set(useTo: DotButtonCount)
}

enum UsingColorModelState {
    case notSet
    case didSet(usingColors: Set<Color>)
}

