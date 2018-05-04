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

    private var buttonPassiveView: DotButtonFieldPassiveView?
    private var fourButtonsPassiveView: FourDotButtonsPassiveViewProtocol?
    private var sixButtonsPassiveView: SixDotButtonsPassiveViewProtocol?
    private var eightButtonsPassiveView: EightDotButtonsPassiveViewProtocol?
    private var sheetModel: DotSheetModelProtocol?
    private var sheetPassiveView: DotSheetPassiveView?
    private var buttonControllerHolder: DotButtonControllerHolder?
    private var restartButtonController: RestartButtonControllerProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let view = self.view as? MainRootView else {
            return
        }

        // TODO: stub
        //let buttonCountRepository = DotButtonCountRepository()
        let buttonCountRepository = StubDotButtonRepository()
        let buttonCountModel = DotButtonCountModel(dependency: buttonCountRepository)
        self.buttonPassiveView = DotButtonFieldPassiveView(
            update: (
                fourButtonsView: view.fourDotButtonsView,
                sixButtonsView: view.sixDotButtonsView,
                eightButtonsView: view.eightDotButtonsView
            ),
            observe: buttonCountModel
        )

        let buttonColorModel = DotButtonColorModel()
        let fourButtonsPassiveView = FourDotButtonsPassiveView(
            views: (
                button1: view.fourDotButtonsView.button1,
                button2: view.fourDotButtonsView.button2,
                button3: view.fourDotButtonsView.button3,
                button4: view.fourDotButtonsView.button4
            ),
            observe: buttonColorModel
        )
        self.fourButtonsPassiveView = fourButtonsPassiveView

        let sixButtonsPassiveView = SixDotButtonsPassiveView(
            views: (
                button1: view.sixDotButtonsView.button1,
                button2: view.sixDotButtonsView.button2,
                button3: view.sixDotButtonsView.button3,
                button4: view.sixDotButtonsView.button4,
                button5: view.sixDotButtonsView.button5,
                button6: view.sixDotButtonsView.button6
            ),
            observe: buttonColorModel
        )
        self.sixButtonsPassiveView = sixButtonsPassiveView

        let eightButtonsPassiveView = EightDotButtonsPassiveView(
            views: (
                button1: view.eightDotButtonsView.button1,
                button2: view.eightDotButtonsView.button2,
                button3: view.eightDotButtonsView.button3,
                button4: view.eightDotButtonsView.button4,
                button5: view.eightDotButtonsView.button5,
                button6: view.eightDotButtonsView.button6,
                button7: view.eightDotButtonsView.button7,
                button8: view.eightDotButtonsView.button8
            ),
            observe: buttonColorModel
        )
        self.eightButtonsPassiveView = eightButtonsPassiveView

        let colorRepository = ColorRepository()
        let usingColorModel = UsingColorModel(
            dependency: (
                colorRepository: colorRepository,
                buttonCountModel: buttonCountModel
            )
        )

        // TODO: stub
        //let dotCountRepository = DotCountRepository()
        let dotCountRepository = StubDotCountRepository()
        let sheetModel = DotSheetResetModel(
            sheetModelFactory: DotSheetModelFactory(
                dotFactory: DotFactory()
            ),
            dotCountRepository: dotCountRepository,
            bindTo: usingColorModel
        )
        self.sheetPassiveView = DotSheetPassiveView(
            update: view.dotSheetView,
            observe: sheetModel
        )
        self.buttonControllerHolder = DotButtonControllerHolder(
            reactTo: (
                fourButtonsView: fourButtonsPassiveView,
                sixButtonsView: sixButtonsPassiveView,
                eightButtonsView: eightButtonsPassiveView
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

extension ViewController {
    class StubDotButtonRepository: DotButtonCountRepositoryProtocol {
        private let counts: [DotButtonCount] = [.four, .six, .eight]
        private var calledCount = 0

        func get() -> DotButtonCount {
            let i = (calledCount % 3)
            calledCount += 1
            return counts[i]
        }
    }

    class StubDotCountRepository: DotCountRepositoryProtocol {
        private let count: [Int] = [6, 8]
        private var calledCount = 0

        func get(minCount: Int, maxCount: Int) -> Int {
            let i = calledCount % count.count
            calledCount += 1
            return count[i]
        }
    }
}
