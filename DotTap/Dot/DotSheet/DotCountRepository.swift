//
// Created by yokoyas000 on 2018/05/03.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import Foundation

protocol DotCountRepositoryProtocol {
    func get(minCount: Int, maxCount: Int) -> Int
}

class DotCountRepository: DotCountRepositoryProtocol {
    func get(minCount: Int, maxCount: Int) -> Int {
        let random = Int(arc4random_uniform(UInt32(maxCount)))
        return random > minCount ? random : minCount
    }
}
