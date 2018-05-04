//
// Created by yokoyas000 on 2018/05/01.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import RxCocoa

protocol DotButtonCountModelProtocol {
    var didChange: Driver<DotButtonCountModelState> { get }
    var currentState: DotButtonCountModelState { get }

    func reset()
}

typealias DotButtonCountModelState = DotButtonCount
