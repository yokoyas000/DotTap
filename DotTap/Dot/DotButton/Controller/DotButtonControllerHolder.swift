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
        dependent buttonModel: DotButtonColorModelProtocol,
        command sheetModel: DotSheetModelProtocol
    ) {
        self.fourDotButtonsController = FourDotButtonsController(
            reactTo: views.fourButtonsView,
            dependent: buttonModel,
            command: sheetModel
        )
        self.sixDotButtonsController = SixDotButtonsController(
            reactTo: views.sixButtonsView,
            dependent: buttonModel,
            command: sheetModel
        )
        self.eightDotButtonsController = EightDotButtonsController(
            reactTo: views.eightButtonsView,
            dependent: buttonModel,
            command: sheetModel
        )
    }

}
