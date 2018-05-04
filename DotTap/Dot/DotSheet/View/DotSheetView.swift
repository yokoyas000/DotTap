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
        let info = Calculate.constraintsInfo(
            maxWidth: self.frame.size.width,
            dotOneSideLength: DotSheetView.dotOneSideLength,
            marginBetweenDots: DotSheetView.marginBetweenDots,
            dotViews: dotViews
        )

        // Dot列が表示されるUIView
        self.dotSheet?.removeFromSuperview()
        let dotSheet = UIView()
        self.dotSheet = dotSheet
        self.addSubview(dotSheet)

        let oneSide = DotSheetView.dotOneSideLength
        let rowHeight = oneSide + DotSheetView.marginBetweenDotRows
        dotSheet.snp.makeConstraints { make in
            make.width.equalTo(info.sheetWidth)
            make.height.equalTo(rowHeight * info.dotRows.count)
            make.center.equalToSuperview()
        }

        // Dot列を一列ずつ作成し、 dotSheetに追加していく
        info.dotRows.enumerated().forEach { (rowIndex, dots) in
            let rowView = UIView()
            dotSheet.addSubview(rowView)

            let dotWidth = DotSheetView.dotOneSideLength + DotSheetView.marginBetweenDots
            let rowWidth = (dots.count * dotWidth) - DotSheetView.marginBetweenDots
            rowView.snp.makeConstraints { make in
                make.width.equalTo(rowWidth)
                make.height.equalTo(rowHeight)
                make.top.equalToSuperview().offset(rowIndex * rowHeight)
                make.centerX.equalToSuperview()
            }

            // Dot列にDotを追加していく
            dots.enumerated().forEach { (i, dot) in
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
