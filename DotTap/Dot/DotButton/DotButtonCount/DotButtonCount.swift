//
//  DotButtonCount.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/27.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

enum DotButtonCount: Int {
    case four = 4
    case six = 6
    case eight = 8

    static var cases: [DotButtonCount] {
        return [
            .four,
            .six,
            .eight
        ]
    }
}
