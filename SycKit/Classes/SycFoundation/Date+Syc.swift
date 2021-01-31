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
        let date: Date = base
        return Calendar.current.startOfDay(for: date)
    }
    
    /// 获取所有月份, 用于选择日期的数据源
    /// - Returns: 月份
    public func getAllMonth() -> [String] {
        let dateformat = DateFormatter()
        dateformat.timeZone = Calendar.current.timeZone
        dateformat.locale = Calendar.current.locale
        /*
         dateformat.monthSymbols // 月份全称
         dateformat.standaloneMonthSymbols // 月份全称
         dateformat.shortMonthSymbols // Jan Feb Mar
         dateformat.veryShortStandaloneMonthSymbols // J F M
         */
        return dateformat.standaloneMonthSymbols
    }
    
    /// 获取星期, 用于选择日期的头部数据源
    /// - Returns: 星期
    public func getShortWeekday() -> [String] {
        let dateformat = DateFormatter()
        dateformat.timeZone = Calendar.current.timeZone
        dateformat.locale = Calendar.current.locale
        /*
        dateformat.weekdaySymbols // EEEE 全称
        dateformat.standaloneWeekdaySymbols // EEEE 全称
        dateformat.shortWeekdaySymbols // EEE
        dateformat.shortStandaloneWeekdaySymbols // EEE
        dateformat.veryShortWeekdaySymbols // E
        dateformat.veryShortStandaloneWeekdaySymbols // E
         */
        return dateformat.shortStandaloneWeekdaySymbols
    }
}
