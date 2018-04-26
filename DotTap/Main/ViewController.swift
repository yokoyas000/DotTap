//
//  ViewController.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/24.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    private var buttonModel: DotButtonModelProtocol?
    private var buttonPassiveView: DotButtonPassiveView?
    private var sheetModel: DotSheetModelProtocol?
    private var sheetPassiveView: DotSheetPassiveView?
    private var buttonControllerHolder: DotButtonControllerHolder?
    private let buttonSetupSignal = BehaviorRelay<Void>(value: ())
    private let disposeBag = DisposeBag()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setup()
    }

    private func setup() {
        guard let view = self.view as? MainRootView else {
            return
        }

        view.restartButton.rx.tap.asSignal().emit(onNext: { [weak self] in
            self?.setup()
        })
        .disposed(by: self.disposeBag)

        let buttonCountRepository = DotButtonCountRepository(count: .four)
        let colorRepository = ColorRepository(dependency: buttonCountRepository)

        let sheetModel = DotSheetResetModel(
            dependency: (
                innerModelFactory: DotSheetModelFactory(
                    dotFactory: DotFactory()
                ),
                colorRepository: colorRepository
            )
        )
        let buttonModel = DotButtonModel(
            dependency: (
                colorRepository: colorRepository,
                buttonCountRepository: buttonCountRepository
            ),
            observe: sheetModel
        )

        let buttonPassiveView = DotButtonPassiveView(
            update: (
                fourButtonsView: StubDotButtonView(),
                sixButtonsView: StubDotButtonView(),
                eightButtonsView: StubDotButtonView()
            ),
            observe: buttonModel
        )
        let sheetPassiveView = DotSheetPassiveView(
            update: view.dotSheetView,
            observe: sheetModel
        )
        let sheetControllerHolder = DotButtonControllerHolder(
            reactTo: (
                fourButtonsView: StubDotButtonView(),
                sixButtonsView: StubDotButtonView(),
                eightButtonsView: StubDotButtonView()
            ),
            depende: buttonModel,
            command: sheetModel
        )

        self.buttonModel = buttonModel
        self.buttonPassiveView = buttonPassiveView
        self.sheetModel = sheetModel
        self.sheetPassiveView = sheetPassiveView
        self.buttonControllerHolder = sheetControllerHolder
    }
}
