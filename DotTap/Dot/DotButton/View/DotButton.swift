//
//  DotButton.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/24.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

@IBDesignable
class DotButton: UIButton {

    var color: UIColor? {
        didSet {
            self.backgroundColor = self.color
        }
    }

    override var isHighlighted: Bool {
        didSet {
            self.isHighlighted
                ? (self.backgroundColor = .darkGray)
                : (self.backgroundColor = self.color)
        }
    }

    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.width / 2
    }

}
