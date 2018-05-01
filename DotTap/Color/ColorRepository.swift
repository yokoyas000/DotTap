//
//  ColorRepository.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/26.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import Foundation

protocol ColorRepositoryProtocol {
    func get(minCount: Int, maxCount: Int) -> Set<Color>
}



class ColorRepository: ColorRepositoryProtocol {

    func get(minCount: Int, maxCount: Int) -> Set<Color> {
        assert(Color.chromatic.count >= maxCount)
        assert(maxCount > minCount)
        return self.selectRandom(minCount: minCount, maxCount: maxCount)
    }

    private func selectRandom(minCount: Int, maxCount: Int) -> Set<Color> {
        var cases = Color.chromatic
        var colors = Set<Color>()

        for _ in 0 ..< minCount {
            let i = Int(arc4random_uniform(UInt32(cases.count)))
            colors.insert(cases[i])

            cases.remove(at: i)
        }

        return colors
    }
}
