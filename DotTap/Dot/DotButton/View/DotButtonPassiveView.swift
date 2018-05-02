//
//  DotButtonPassiveView.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/25.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol DotButtonFieldPassiveViewProtocol {}



class DotButtonFieldPassiveView: DotButtonFieldPassiveViewProtocol {

    typealias Views = (
        fourButtonsView: UIView,
        sixButtonsView: UIView,
        eightButtonsView: UIView
    )
    private let views: Views
    private let disposeBag = DisposeBag()

    init(
        update views: Views,
        observe buttonCountModel: DotButtonCountModelProtocol
    ) {
        self.views = views

        buttonCountModel.didChange
            .drive(onNext: { [weak self] state in
                self?.updateCount(by: state)
            })
            .disposed(by: self.disposeBag)
    }

    private func updateCount(by buttonState: DotButtonCountModelState) {
        switch buttonState {
        case .four:
            self.views.fourButtonsView.isHidden = false
            self.views.sixButtonsView.isHidden = true
            self.views.eightButtonsView.isHidden = true
        case .six:
            self.views.fourButtonsView.isHidden = true
            self.views.sixButtonsView.isHidden = false
            self.views.eightButtonsView.isHidden = true
        case .eight:
            self.views.fourButtonsView.isHidden = true
            self.views.sixButtonsView.isHidden = true
            self.views.eightButtonsView.isHidden = false
        }
    }

}
