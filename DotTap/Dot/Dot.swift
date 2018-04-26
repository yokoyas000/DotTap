//
//  Dot.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/25.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

struct Dot: Equatable {
    let color: Color

    static func == (lhs: Dot, rhs: Dot) -> Bool {
        return lhs.color == rhs.color
    }
}

struct ComparableDot: Equatable {
    var color: Color
    var isDidMatch: Bool

    static func == (lhs: ComparableDot, rhs: ComparableDot) -> Bool {
        return lhs.color == rhs.color
            && lhs.isDidMatch == rhs.isDidMatch
    }
}
