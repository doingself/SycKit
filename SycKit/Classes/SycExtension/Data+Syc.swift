//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import Foundation

public extension SycStruct where Base == Data {
    /// Data 转 String
    var stringValue: String? { base.stringValue }
}

extension Data {
    /// Data 转 String
    var stringValue: String? {
        return String(data: self, encoding: String.Encoding.utf8)
    }
}
