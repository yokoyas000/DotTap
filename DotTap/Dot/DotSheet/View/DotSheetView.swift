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
    private static let marginBetweenDots = DotSheetView.dotOneSideLength / 2
    private static let marginBetweenDotRows = DotSheetView.dotOneSideLength / 4
    private var dotSheet: UIView? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadFromNib()
    }

    func set(dotViews: [DotView]) {
        let info = Calculate.infoForConstraints(
            maxWidth: self.frame.size.width,
            dotOneSideLength: DotSheetView.dotOneSideLength,
            marginBetweenDots: DotSheetView.marginBetweenDots,
            dotCount: dotViews.count
        )
        let oneSide = DotSheetView.dotOneSideLength

        self.dotSheet?.removeFromSuperview()
        let dotSheet = UIView()
        self.dotSheet = dotSheet
        self.addSubview(dotSheet)
        let rowHeight = oneSide + DotSheetView.marginBetweenDotRows
        dotSheet.snp.makeConstraints { make in
            make.width.equalTo(info.sheetWidth)
            make.height.equalTo(rowHeight * info.dotRowCount)
            make.center.equalToSuperview()
        }

        for row in 0 ..< info.dotRowCount {
            let rowView = UIView()
            dotSheet.addSubview(rowView)

            let startIndex = row * info.dotColumnCount
            var endIndex = startIndex + info.dotColumnCount
            endIndex = endIndex < dotViews.endIndex ? endIndex : dotViews.endIndex
            let rowDots = dotViews[startIndex ..< endIndex]

            let dotWidth = DotSheetView.dotOneSideLength + DotSheetView.marginBetweenDots
            rowView.snp.makeConstraints { make in
                make.width.equalTo((rowDots.count * dotWidth) - DotSheetView.marginBetweenDots)
                make.height.equalTo(rowHeight)
                make.top.equalToSuperview().offset(row * rowHeight)
                make.centerX.equalToSuperview()
            }

            rowDots.enumerated().forEach { (i, dot) in
                rowView.addSubview(dot)

                dot.snp.makeConstraints { make in
                    make.width.equalTo(oneSide)
                    make.height.equalTo(oneSide)
                    make.top.equalToSuperview()
                    make.left.equalToSuperview().offset(dotWidth * i)
                }
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
