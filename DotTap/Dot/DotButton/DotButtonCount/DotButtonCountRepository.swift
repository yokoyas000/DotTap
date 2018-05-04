//
//  DotButtonCountRepository.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/27.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import Foundation

protocol DotButtonCountRepositoryProtocol {
    func get() -> DotButtonCount
}



class DotButtonCountRepository: DotButtonCountRepositoryProtocol {
     func get() -> DotButtonCount {
        let random = Int(arc4random_uniform(UInt32(DotButtonCount.cases.count)))
        return DotButtonCount.cases[random]
    }
}
