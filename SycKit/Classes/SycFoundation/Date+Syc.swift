//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import Foundation

extension SycStruct where Base == Date {
    public func startDay() -> Date {
        let date = Calendar.current.startOfDay(for: base)
        return date
    }
}
