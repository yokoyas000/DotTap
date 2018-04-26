//
//  DotView.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/24.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

class DotView: UIView {

    static let oneSideLength: CGFloat = 10.0

    var color: UIColor? {
        get {
            return self.backgroundColor
        }
        set {
            self.backgroundColor = newValue
        }
    }

    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.width / 2
    }

}
