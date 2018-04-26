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
    func resetColors()
}

class ColorRepository: ColorRepositoryProtocol {

    let minColorCount: Int
    let maxColorCount: Int

    private(set) var colors: [Color] = []

    init(minColorCount: Int, maxColorCount: Int) {
        assert(Color.chromatic.count >= maxColorCount)
        assert(maxColorCount > minColorCount)

        self.minColorCount = minColorCount
        self.maxColorCount = maxColorCount
        self.colors = self.makeColors()
    }

    func resetColors() {
        self.colors = self.makeColors()
    }

    private func makeColors() -> [Color] {
        var cases = Color.chromatic
        var colors: [Color] = []

        for _ in 0 ..< self.maxColorCount {
            let i = Int(arc4random_uniform(UInt32(cases.count)))
            colors.append(cases[i])

            cases.remove(at: i)
        }

        let randomLength = Int(arc4random_uniform(UInt32(self.maxColorCount)))
        let colorLength = randomLength > self.minColorCount ? randomLength : self.minColorCount

        return colors[0...colorLength].map { $0 }
    }
}
