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
    var currentState: DotButtonModelState { get }
}

typealias DotButtonModelState = DotButtonModelColor
typealias DotButtonModelColor = [Color]
