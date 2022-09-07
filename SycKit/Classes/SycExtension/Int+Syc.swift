//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import UIKit

public extension SycStruct where Base == Int {
    var stringValue: String {
        return base.stringValue
    }
}

extension Int {
    var stringValue: String {
        return "\(self)"
    }
}
