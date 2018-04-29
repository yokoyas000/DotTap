//
//  DotButtonCountRepository.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/27.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

protocol DotButtonCountRepositoryProtocol {
    var count: DotButtonCount { get }
    func reset(count: DotButtonCount)
}

class DotButtonCountRepository: DotButtonCountRepositoryProtocol {
    private(set) var count: DotButtonCount

    init(count: DotButtonCount) {
        assert(Color.chromatic.count >= count.rawValue)
        self.count = count
    }

    func reset(count: DotButtonCount) {
        self.count = count
    }
}
