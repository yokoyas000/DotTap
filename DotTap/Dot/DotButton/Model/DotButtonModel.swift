//
// Created by yokoyas000 on 2018/04/29.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

protocol DotButtonModelProtocol {
    func reset()
}



/**
  ボタン数や表示されるドットの作成を行う
  - 順序:
    - ボタンの数を決める
    - 使用する色を決める
    - ボタンを作る
 **/
import RxSwift
import RxCocoa

class DotButtonModel: DotButtonModelProtocol {

    private let buttonCountModel: DotButtonCountModelProtocol
    private let buttonColorModel: DotButtonColorModelProtocol
    private let usingColorModel: UsingColorModelProtocol
    private let disposeBag = DisposeBag()

    init(
        buttonCountModel: DotButtonCountModelProtocol,
        buttonColorModel: DotButtonColorModelProtocol,
        usingColorModel: UsingColorModelProtocol
    ) {
        self.buttonCountModel = buttonCountModel
        self.buttonColorModel = buttonColorModel
        self.usingColorModel = usingColorModel

        // 使用する色が変わったらボタンの色も変える
        self.usingColorModel.didChange.drive(onNext: { [weak self] colors in
                guard let this = self else { return }
                this.buttonColorModel.set(
                    colors: colors,
                    buttonCount: this.buttonCountModel.currentState
                )
            })
            .disposed(by: self.disposeBag)
    }

    func reset() {
        self.buttonCountModel.reset()
        self.usingColorModel.reset()
    }

}