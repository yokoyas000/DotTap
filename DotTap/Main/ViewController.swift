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
    private var sheetController: DotSheetController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        guard let view = self.view as? MainRootView else {
            return
        }

        let sheetModelFactory = DotSheetModelFactory(
            dotFactory: DotFactory()
        )
        let colorRepository = ColorRepository(
            minColorCount: DotSheet.minUsingColorCount,
            maxColorCount: DotSheet.buttonCount
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
        let sheetController = DotSheetController(
            reactTo: DotSheetController.Views(
                button1: view.dotButtonFieldView.button1,
                button2: view.dotButtonFieldView.button2,
                button3: view.dotButtonFieldView.button3,
                button4: view.dotButtonFieldView.button4
                ),
            depende: buttonModel,
            command: sheetModel
        )

        self.buttonModel = buttonModel
        self.buttonPassiveView = buttonPassiveView
        self.sheetModel = sheetModel
        self.sheetPassiveView = sheetPassiveView
        self.sheetController = sheetController
    }
}
