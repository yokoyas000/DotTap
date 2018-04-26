//
//  Result.swift
//  DotTap
//
//  Created by yokoyas000 on 2018/04/24.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
