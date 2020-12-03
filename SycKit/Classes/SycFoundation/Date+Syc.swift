//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import Foundation

extension SycStruct where Base == Date {
    
    /// 获取 date 的当天开始时间
    /// - Returns: date (yyyy-mm-dd 00:00:00)
    public func startDay() -> Date {
        let date = Calendar.current.startOfDay(for: base)
        return date
    }
}
