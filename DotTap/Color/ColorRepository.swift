//
//  ColorRepository.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/26.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import Foundation

protocol ColorRepositoryProtocol {
    var colors: [Color] { get }
    func resetColors(minCount: Int, maxCount: Int)
}

class ColorRepository: ColorRepositoryProtocol {

    // 画面上で利用する色
    private(set) var colors: [Color] = []

    init(minCount: Int, maxCount: Int) {
        assert(Color.chromatic.count >= maxCount)
        assert(maxCount > minCount)

        self.colors = self.create(minCount: minCount, maxCount: maxCount)
    }

    func resetColors(minCount: Int, maxCount: Int) {
        self.colors = self.create(minCount: minCount, maxCount: maxCount)
    }

    private func create(minCount: Int, maxCount: Int) -> [Color] {
        var cases = Color.chromatic
        var colors: [Color] = []

        for _ in 0 ..< minCount {
            let i = Int(arc4random_uniform(UInt32(cases.count)))
            colors.append(cases[i])

            cases.remove(at: i)
        }

        let randomCount = Int(arc4random_uniform(UInt32(minCount)))
        let colorCount = randomCount > minCount ? randomCount : minCount

        return colors[0...colorCount].map { $0 }
    }
}
