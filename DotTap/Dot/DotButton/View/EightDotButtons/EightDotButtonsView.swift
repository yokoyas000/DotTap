//
//  Created by yokoyas000 on 2018/05/02.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

import UIKit

@IBDesignable
class EightDotButtonsView: UIView {

    @IBOutlet weak var button1: DotButton!
    @IBOutlet weak var button2: DotButton!
    @IBOutlet weak var button3: DotButton!
    @IBOutlet weak var button4: DotButton!
    @IBOutlet weak var button5: DotButton!
    @IBOutlet weak var button6: DotButton!
    @IBOutlet weak var button7: DotButton!
    @IBOutlet weak var button8: DotButton!

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

        view.frame = self.bounds
        self.addSubview(view)
    }
}
