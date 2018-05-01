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

    private var buttonPassiveView: DotButtonPassiveView?
    private var sheetModel: DotSheetModelProtocol?
    private var sheetPassiveView: DotSheetPassiveView?
    private var buttonControllerHolder: DotButtonControllerHolder?
    private var restartButtonController: RestartButtonControllerProtocol?

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let view = self.view as? MainRootView else {
            return
        }

        let buttonCountRepository = DotButtonCountRepository()
        let buttonCountModel = DotButtonCountModel(dependency: buttonCountRepository)
        let buttonColorModel = DotButtonColorModel()
        let colorRepository = ColorRepository()
        let usingColorModel = UsingColorModel(
            dependency: (
                colorRepository: colorRepository,
                buttonCountModel: buttonCountModel
            )
        )

        self.buttonPassiveView = DotButtonPassiveView(
            update: (
                fourButtonsView: StubDotButtonView(),
                sixButtonsView: StubDotButtonView(),
                eightButtonsView: StubDotButtonView()
            ),
            observe: (
                buttonCountModel: buttonCountModel,
                buttonColorModel: buttonColorModel
            )
        )

        let sheetModel = DotSheetResetModel(
            sheetModelFactory: DotSheetModelFactory(
                dotFactory: DotFactory()
            ),
            bindTo: usingColorModel
        )

        self.sheetPassiveView = DotSheetPassiveView(
            update: view.dotSheetView,
            observe: sheetModel
        )
        self.buttonControllerHolder = DotButtonControllerHolder(
            reactTo: (
                fourButtonsView: StubDotButtonView(),
                sixButtonsView: StubDotButtonView(),
                eightButtonsView: StubDotButtonView()
            ),
            dependent: buttonColorModel,
            command: sheetModel
        )

        let buttonModel = DotButtonModel(
            buttonCountModel: buttonCountModel,
            buttonColorModel: buttonColorModel,
            usingColorModel: usingColorModel
        )
        self.restartButtonController = RestartButtonController(
            reactTo: view.restartButton,
            command: buttonModel
        )

    }

}
