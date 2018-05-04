//
//  MainRootView.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/24.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

@IBDesignable
class MainRootView: UIView {

    @IBOutlet weak var dotSheetView: DotSheetView!
    @IBOutlet var fourDotButtonsView: FourDotButtonsView!
    @IBOutlet weak var sixDotButtonsView: SixDotButtonsView!
    @IBOutlet weak var eightDotButtonsView: EightDotButtonsView!
    @IBOutlet var restartButton: RestartButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadFromNib()
    }

    private func loadFromNib() {
        let className = String(describing: type(of: self))
        guard let view = Bundle(for: type(of: self))
            .loadNibNamed(className, owner: self, options: nil)?
            .first as? UIView else {
                print("Failed to load \(className)")
                return
        }

        view.frame = self.frame
        self.addSubview(view)
    }

}
