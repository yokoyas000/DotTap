//
//  RestartButton.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/27.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

@IBDesignable
class RestartButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }

}
