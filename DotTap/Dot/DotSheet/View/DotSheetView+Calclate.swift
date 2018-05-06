//
// Created by yokoyas000 on 2018/05/03.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import CoreGraphics

extension DotSheetView {

    struct ConstraintsInfo {
        let sheetWidth: CGFloat
        let dotColumnCount: Int
        let dotRows: [[DotView]]
    }

    enum Calculate {
        static func constraintsInfo(
            maxWidth: CGFloat,
            dotOneSideLength: Int,
            marginBetweenDots: Int,
            dotViews: [DotView]
        ) -> ConstraintsInfo {
            let dotWidth = dotOneSideLength + marginBetweenDots
            let allDotsWidth = CGFloat((dotWidth * dotViews.count) - marginBetweenDots) // 末尾のmarginを削除
            let dotRowCount = self.calcDotRowCount(maxWidth, dotsWidth: allDotsWidth)
            let sheetWidth = dotRowCount > 1 ? maxWidth : allDotsWidth
            let dotColumnCount = (Int(sheetWidth) + marginBetweenDots) / dotWidth

            var dotRows: [[DotView]] = []
            for i in 0 ..< dotRowCount {
                let startIndex = i * dotColumnCount
                var endIndex = startIndex + dotColumnCount
                endIndex = endIndex < dotViews.endIndex ? endIndex : dotViews.endIndex
                let rowDots = dotViews[startIndex ..< endIndex].map { $0 }
                dotRows.append(rowDots)
            }

            return ConstraintsInfo(
                sheetWidth: sheetWidth,
                dotColumnCount: dotColumnCount,
                dotRows: dotRows
            )
        }

        private static func calcDotRowCount(
            _ maxWidth: CGFloat, dotsWidth: CGFloat, dotRowCount: Int = 1
        ) -> Int {
            guard dotsWidth > maxWidth else {
                return dotRowCount
            }
            return calcDotRowCount(maxWidth, dotsWidth: dotsWidth - maxWidth, dotRowCount: dotRowCount + 1)
        }
    }
}

