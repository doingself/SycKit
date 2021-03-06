//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import Foundation

extension SycStruct where Base == Data {
    
    /// Data 转 String
    /// - 用法: data.yc.convertUTF8Str()
    /// - Returns: string
    public func convertUTF8Str() -> String? {
        return String(data: base, encoding: String.Encoding.utf8)
    }
}
