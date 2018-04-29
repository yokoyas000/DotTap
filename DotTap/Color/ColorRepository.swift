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
    func resetColors(maxNumber: Int, minNumber: Int)
}

class ColorRepository: ColorRepositoryProtocol {

    // 画面上で利用する色
    private(set) var colors: [Color] = []

    init(maxNumber: Int, minNumber: Int) {
        assert(Color.chromatic.count >= maxNumber)
        assert(maxNumber > minNumber)

        self.colors = self.create(maxNumber: maxNumber, minNumber: minNumber)
    }

    func resetColors(maxNumber: Int, minNumber: Int) {
        self.colors = self.create(maxNumber: maxNumber, minNumber: minNumber)
    }

    private func create(maxNumber: Int, minNumber: Int) -> [Color] {
        var cases = Color.chromatic
        var colors: [Color] = []

        for _ in 0 ..< maxNumber {
            let i = Int(arc4random_uniform(UInt32(cases.count)))
            colors.append(cases[i])

            cases.remove(at: i)
        }

        let randomLength = Int(arc4random_uniform(UInt32(maxNumber)))
        let colorLength = randomLength > minNumber ? randomLength : minNumber

        return colors[0...colorLength].map { $0 }
    }
}
