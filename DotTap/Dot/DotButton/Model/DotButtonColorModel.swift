//
// Created by yokoyas000 on 2018/05/01.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import RxCocoa

class DotButtonColorModel: DotButtonColorModelProtocol {

    private let relay = BehaviorRelay<DotButtonColorModelState> (value: .notSet)

    var didChange: Driver<DotButtonColorModelState> {
        return self.relay.asDriver()
    }

    private(set) var currentState: DotButtonColorModelState {
        get {
            return self.relay.value
        }
        set {
            self.relay.accept(newValue)
        }
    }

    func set(colors: Set<Color>, buttonCount: DotButtonCount) {
        guard buttonCount.rawValue >= colors.count else {
            return
        }

        let buttonColor = DotButtonColorFactory.create(colors: colors, buttonCount: buttonCount)
        self.currentState = .didSet(color: buttonColor)
    }
}



extension DotButtonColorModel {

    enum DotButtonColorFactory {
        static func create(
            colors: Set<Color>,
            buttonCount: DotButtonCount
        ) -> DotButtonColorModelState.DotButtonColor {
            assert(buttonCount.rawValue >= colors.count)

            var buttonColors: [Color] = colors.map { $0 }

            // 色数がボタン数より少ない場合、同じ色のボタンを複数作る
            let more = buttonCount.rawValue - colors.count
            if more > 0 {
                for _ in colors.count ..< (colors.count + more) {
                    let random = Int(arc4random_uniform(UInt32(buttonColors.count)))
                    buttonColors.append(buttonColors[random])
                }
            }

            switch buttonCount {
            case .four:
                return DotButtonColorModelState.DotButtonColor.four(
                    colors: DotButtonColorModelState.DotButtonFourColors(
                        one: buttonColors[0],
                        two: buttonColors[1],
                        three: buttonColors[2],
                        four: buttonColors[3]
                    )
                )
            case .six:
                return DotButtonColorModelState.DotButtonColor.six(
                    colors: DotButtonColorModelState.DotButtonSixColors(
                        one: buttonColors[0],
                        two: buttonColors[1],
                        three: buttonColors[2],
                        four: buttonColors[3],
                        five: buttonColors[4],
                        six: buttonColors[5]
                    )
                )
            case .eight:
                return DotButtonColorModelState.DotButtonColor.eight(
                    colors: DotButtonColorModelState.DotButtonEightColors(
                        one: buttonColors[0],
                        two: buttonColors[1],
                        three: buttonColors[2],
                        four: buttonColors[3],
                        five: buttonColors[4],
                        six: buttonColors[5],
                        seven: buttonColors[6],
                        eight: buttonColors[7]
                    )
                )
            }
        }
    }

}