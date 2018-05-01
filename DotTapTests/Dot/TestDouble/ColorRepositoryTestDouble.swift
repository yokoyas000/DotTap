//
// Created by yokoyas000 on 2018/04/29.
// Copyright (c) 2018 yokoyas000. All rights reserved.
//

class StubColorRepository: ColorRepositoryProtocol {
    private(set) var colors: Set<Color>

    init(colors: Set<Color> = []) {
        self.colors = colors
    }

    func setColors(minCount: Int, maxCount: Int) {}
}
