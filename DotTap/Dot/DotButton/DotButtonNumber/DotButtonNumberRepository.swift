//
//  DotButtonNumberRepository.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/27.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

protocol DotButtonNumberRepositoryProtocol {
    var number: DotButtonNumber { get }
    func reset(count: DotButtonNumber)
}

class DotButtonNumberRepository: DotButtonNumberRepositoryProtocol {
    private(set) var number: DotButtonNumber

    init(count: DotButtonNumber) {
        assert(Color.chromatic.count >= count.rawValue)
        self.number = count
    }

    func reset(count: DotButtonNumber) {
        self.number = count
    }
}
