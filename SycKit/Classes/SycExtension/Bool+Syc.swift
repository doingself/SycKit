//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import UIKit

public extension SycStruct where Base == Bool {
    var intValue: Int {
        return base.intValue
    }
    var stringValue: String {
        return base.stringValue
    }
}

extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
    var stringValue: String {
        return self ? "true" : "false"
    }
}
