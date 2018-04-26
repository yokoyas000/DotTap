//
//  DotSheetControllerHolder.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/25.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

class DotButtonControllerHolder {

    private let fourDotButtonsController: FourDotButtonsController
    private let sixDotButtonsController: SixDotButtonsController
    private let eightDotButtonsController: EightDotButtonsController

    init(
        reactTo views: (
            fourButtonsView: FourDotButtonsViewProtocol,
            sixButtonsView: SixDotButtonsViewProtocol,
            eightButtonsView: EightDotButtonsViewProtocol
        ),
        depende buttonModel: DotButtonModelProtocol,
        command sheetModel: DotSheetModelProtocol
    ) {
        self.fourDotButtonsController = FourDotButtonsController(
            reactTo: views.fourButtonsView,
            depende: buttonModel,
            command: sheetModel
        )
        self.sixDotButtonsController = SixDotButtonsController(
            reactTo: views.sixButtonsView,
            depende: buttonModel,
            command: sheetModel
        )
        self.eightDotButtonsController = EightDotButtonsController(
            reactTo: views.eightButtonsView,
            depende: buttonModel,
            command: sheetModel
        )
    }

}
