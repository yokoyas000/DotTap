//
// Created by yokoyas000 on 2018/05/03.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

import CoreGraphics

extension DotSheetView {
    enum Calculate {
        static func infoForConstraints(
            maxWidth: CGFloat,
            dotOneSideLength: Int,
            marginBetweenDots: Int,
            dotCount: Int
        ) -> (sheetWidth: CGFloat, dotRowCount: Int, dotColumnCount: Int) {
            let dotWidth = dotOneSideLength + marginBetweenDots
            let allDotsWidth = CGFloat((dotWidth * dotCount) - marginBetweenDots) // 末尾のmarginを削除
            let dotRowCount = self.calcDotRowCount(maxWidth, dotsWidth: allDotsWidth)
            let sheetWidth = dotRowCount > 1 ? maxWidth : allDotsWidth

            return (
                sheetWidth: sheetWidth,
                dotRowCount: dotRowCount,
                dotColumnCount: (Int(sheetWidth) + marginBetweenDots) / dotWidth
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

