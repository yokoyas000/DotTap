//
// Created by yokoyas000 on 2018/04/29.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import RxCocoa

protocol UsingColorModelProtocol {
    var didChange: Driver<UsingColorModelState> { get }
    var currentState: UsingColorModelState { get }
    func reset()
}

typealias UsingColorModelState =  Set<Color>
