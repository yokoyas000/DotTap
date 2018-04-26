//
//  DotButtonCountRepository.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/27.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

protocol DotButtonCountRepositoryProtosol {
    var count: DotButtonCount { get }
}

class DotButtonCountRepository: DotButtonCountRepositoryProtosol {
    let count: DotButtonCount

    init(count: DotButtonCount) {
        assert(Color.chromatic.count >= count.rawValue)
        self.count = count
    }
}
