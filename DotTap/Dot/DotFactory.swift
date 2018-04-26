//
//  DotFactory.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/26.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import Foundation

protocol DotFactoryProtocol {
    func create(length: Int, usingColors: [Color]) -> [Dot]
}

struct DotFactory: DotFactoryProtocol {

    func create(length: Int, usingColors: [Color]) -> [Dot] {
        var dots: [Dot] = usingColors.map { color in
            Dot(color: color)
        }

        if length < usingColors.count {
            let lessCount = usingColors.count - length
            for _ in 0 ..< lessCount {
                let randomDotsIndex = Int(arc4random_uniform(UInt32(dots.count)))
                dots.remove(at: randomDotsIndex)
            }
        } else {
            let moreAddCount = length - usingColors.count
            for _ in 0 ..< moreAddCount {
                let randomColorIndex = Int(arc4random_uniform(UInt32(usingColors.count)))
                dots.append(Dot(color: usingColors[randomColorIndex]))
            }
        }

        var suffleDots: [Dot] = []
        for _ in 0 ..< dots.count {
            let i = Int(arc4random_uniform(UInt32(dots.count)))
            suffleDots.append(dots[i])
            dots.remove(at: i)
        }

        return suffleDots
    }

}
