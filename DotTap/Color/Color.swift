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
    case pink
    case purple
    case lightBlue
    case green
    case gray

    static var chromatic: [Color] {
        return [
            .orange,
            .pink,
            .purple,
            .lightBlue,
            .green
        ]
    }

    var value: UIColor {
        switch self {
        case .orange:
            return UIColor(red: 255/255, green: 191/255, blue: 81/255, alpha: 1.0)
        case .pink:
            return UIColor(red: 255/255, green: 159/255, blue: 169/255, alpha: 1.0)
        case .purple:
            return UIColor(red: 225/255, green: 181/255, blue: 223/255, alpha: 1.0)
        case .lightBlue:
            return UIColor(red: 139/255, green: 211/255, blue: 255/255, alpha: 1.0)
        case .green:
            return UIColor(red: 217/255, green: 233/255, blue: 44/255, alpha: 1.0)
        case .gray:
            return UIColor(red: 184/255, green: 184/255, blue: 184/255, alpha: 1.0)
        }
    }

}
