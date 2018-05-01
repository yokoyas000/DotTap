//
//  DotSheetModelFactory.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/26.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

protocol DotSheetModelFactoryProtocol {
    func create(dotCount: Int, usingColors: Set<Color>) -> DotSheetModelProtocol
}

struct DotSheetModelFactory: DotSheetModelFactoryProtocol {
    
    private let dotFactory: DotFactoryProtocol
    
    init(
        dotFactory: DotFactoryProtocol
    ) {
        self.dotFactory = dotFactory
    }
    
    func create(dotCount: Int, usingColors: Set<Color>) -> DotSheetModelProtocol {
        let dots = self.dotFactory.create(
            count: dotCount,
            usingColors: usingColors
        )
        return DotSheetModel(baseDots: dots)
    }
    
}

