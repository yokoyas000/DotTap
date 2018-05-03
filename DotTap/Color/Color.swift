//
//  Color.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/25.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

enum Color {
    case orange
    case lightPink
    case pink
    case purple
    case blue
    case lightBlue
    case turquoiseBlue
    case green
    case emeraldGreen
    case lightGreen
    case gray

    static var chromatic: [Color] {
        return [
            .orange,
            .lightPink,
            .pink,
            .purple,
            .blue,
            .lightBlue,
            .turquoiseBlue,
            .green,
            .emeraldGreen,
            .lightGreen
        ]
    }

    var value: UIColor {
        switch self {
        case .orange:
            return UIColor(red: 255/255, green: 191/255, blue: 81/255, alpha: 1.0)
        case .lightPink:
            return UIColor(red: 255/255, green: 159/255, blue: 169/255, alpha: 1.0)
        case .pink:
            return UIColor(red: 255/255, green: 96/255, blue: 132/255, alpha: 1.0)
        case .purple:
            return UIColor(red: 225/255, green: 181/255, blue: 223/255, alpha: 1.0)
        case .blue:
            return UIColor(red: 158/255, green: 178/255, blue: 251/255, alpha: 1.0)
        case .lightBlue:
            return UIColor(red: 168/255, green: 230/255, blue: 222/255, alpha: 1.0)
        case .turquoiseBlue:
            return UIColor(red: 78/255, green: 183/255, blue: 217/255, alpha: 1.0)
        case .green:
            return UIColor(red: 168/255, green: 191/255, blue: 53/255, alpha: 1.0)
        case .emeraldGreen:
            return UIColor(red: 113/255, green: 200/255, blue: 153/255, alpha: 1.0)
        case .lightGreen:
            return UIColor(red: 217/255, green: 233/255, blue: 44/255, alpha: 1.0)
        case .gray:
            return UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        }
    }

}
