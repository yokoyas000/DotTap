//
//  DotViewFactory.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/25.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

struct DotViewFactory {
    static func create(dots: [Dot]) -> [DotView] {
        return dots.map { dot in
            let dotView = DotView()
            dotView.color = dot.color.value
            return dotView
        }
    }
}
