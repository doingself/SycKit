//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import Foundation

public extension SycStruct where Base == Date {
    
    static var current: Date {
        return Base.current
    }
    
    /// 时间字符串
    func stringValue(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        return base.stringValue(format: format)
    }
    
    /// 获取 date 的开始时间, 时分秒=0
    /// - Returns: date (yyyy-mm-dd 00:00:00)
    var startDay: Date {
        return base.startDay
    }
}

extension Date {
    
    static var current: Date {
        if #available(iOS 15, *) {
            return Date.now
        } else {
            return Date()
        }
    }
    
    /// 时间字符串
    func stringValue(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = format
        return fmt.string(from: self)
    }
    
    /// 获取 date 的开始时间, 时分秒=0
    /// - Returns: date (yyyy-mm-dd 00:00:00)
    var startDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
}
