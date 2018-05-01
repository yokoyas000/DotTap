//
//  DotFactory.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/26.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import Foundation

protocol DotFactoryProtocol {
    func create(count: Int, usingColors: Set<Color>) -> [Dot]
}

struct DotFactory: DotFactoryProtocol {

    func create(count: Int, usingColors: Set<Color>) -> [Dot] {
        assert(usingColors.count > 0)

        var dots: [Dot] = usingColors.map { color in
            Dot(color: color)
        }

        if count < dots.count {
            let removeCount = dots.count - count
            for _ in 0 ..< removeCount {
                let randomDotsIndex = Int(arc4random_uniform(UInt32(dots.count)))
                dots.remove(at: randomDotsIndex)
            }
        } else {
            let addCount = count - dots.count
            for _ in 0 ..< addCount {
                let randomDotsIndex = Int(arc4random_uniform(UInt32(dots.count)))
                dots.append(Dot(color: dots[randomDotsIndex].color))
            }
        }

        var shuffleDots: [Dot] = []
        for _ in 0 ..< dots.count {
            let i = Int(arc4random_uniform(UInt32(dots.count)))
            shuffleDots.append(dots[i])
            dots.remove(at: i)
        }

        return shuffleDots
    }

}
