//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import UIKit

extension SycStruct where Base: Bundle {
    
    /// 获取 App CFBundleName 信息
    /// - 用法: Bundle.main.yc.getCFBundleName()
    /// - Returns: CFBundleName
    public func getCFBundleName() -> String? {
        //Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
        return base.object(forInfoDictionaryKey: "CFBundleName") as? String
    }
}
