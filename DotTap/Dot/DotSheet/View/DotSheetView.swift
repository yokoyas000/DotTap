//
//  DotSheetView.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/24.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit
import SnapKit

class DotSheetView: UIView {

    private static let dotOneSideLength = 20
    private var dotViews: [DotView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadFromNib()
    }

    func set(dotViews: [DotView]) {
        self.dotViews.forEach { $0.removeFromSuperview() }
        self.dotViews = dotViews

        let oneSide = DotSheetView.dotOneSideLength
        self.snp.updateConstraints { make in
            make.width.equalTo(dotViews.count * oneSide * 2)
        }

        dotViews.enumerated().forEach { i, dot in
            self.addSubview(dot)
            dot.snp.makeConstraints { make in
                make.width.equalTo(oneSide)
                make.height.equalTo(oneSide)
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(i * oneSide * 2)
            }
        }

        self.layoutIfNeeded()
    }

    private func loadFromNib() {
        let className = String(describing: type(of: self))
        guard let view = Bundle(for: type(of: self))
            .loadNibNamed(className, owner: self, options: nil)?
            .first as? UIView else {
                print("Failed to load \(className)")
                return
        }

        view.frame = self.bounds
        self.addSubview(view)
    }

}
