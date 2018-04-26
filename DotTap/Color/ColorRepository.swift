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

    private let buttonCountRepository: DotButtonCountRepositoryProtosol
    private(set) var colors: [Color] = []

    init(dependency buttonCountRepository: DotButtonCountRepositoryProtosol) {
        self.colors = self.makeColors()
    }

    func resetColors() {
        self.colors = self.makeColors()
    }

    private func makeColors() -> [Color] {
        let minColorCount: Int = self.buttonCountRepository.count.rawValue / 2
        let maxColorCount: Int = self.buttonCountRepository.count.rawValue

        var cases = Color.chromatic
        var colors: [Color] = []

        for _ in 0 ..< maxColorCount {
            let i = Int(arc4random_uniform(UInt32(cases.count)))
            colors.append(cases[i])

            cases.remove(at: i)
        }

        let randomLength = Int(arc4random_uniform(UInt32(maxColorCount)))
        let colorLength = randomLength > minColorCount ? randomLength : minColorCount

        return colors[0...colorLength].map { $0 }
    }
}
