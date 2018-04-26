//
//  ViewController.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/24.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit
import RxCocoa

class ViewController: UIViewController {

    private var buttonModel: DotButtonModelProtocol?
    private var buttonPassiveView: DotButtonPassiveView?
    private var sheetModel: DotSheetModelProtocol?
    private var sheetPassiveView: DotSheetPassiveView?
    private var buttonController: DotButtonController?

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        guard let view = self.view as? MainRootView else {
            return
        }

        let sheetModelFactory = DotSheetModelFactory(
            dotFactory: DotFactory()
        )
        let colorRepository = ColorRepository(
            minColorCount: DotSheet.minUsingColorCount,
            maxColorCount: DotSheet.maxUsingColorCount
        )
        let sheetModel = DotSheetResetModel(
            dependency: (
                innerModelFactory: sheetModelFactory,
                colorRepository: colorRepository
            )
        )
        let buttonModel = DotButtonModel(
            observe: sheetModel,
            colorRepository: colorRepository
        )

        let buttonPassiveView = DotButtonPassiveView(
            update: [
                view.dotButtonFieldView.button1,
                view.dotButtonFieldView.button2,
                view.dotButtonFieldView.button3,
                view.dotButtonFieldView.button4
            ],
            observe: buttonModel
        )
        let sheetPassiveView = DotSheetPassiveView(update: view.dotSheetView, observe: sheetModel)
        let sheetController = DotButtonController(
            reactTo: [
                view.dotButtonFieldView.button1.rx.tap.asSignal(),
                view.dotButtonFieldView.button2.rx.tap.asSignal(),
                view.dotButtonFieldView.button3.rx.tap.asSignal(),
                view.dotButtonFieldView.button4.rx.tap.asSignal()
            ],
            depende: buttonModel,
            command: sheetModel
        )

        self.buttonModel = buttonModel
        self.buttonPassiveView = buttonPassiveView
        self.sheetModel = sheetModel
        self.sheetPassiveView = sheetPassiveView
        self.buttonController = sheetController
    }
}
