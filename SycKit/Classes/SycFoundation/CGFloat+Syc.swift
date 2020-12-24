//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import UIKit

extension CGFloat {
    public enum yc {
        /// 获取状态栏高度
        public static let statusBarHeight: CGFloat = {
            return UIApplication.shared.statusBarFrame.height
        }()
        /// 获取 navigationBar 高度
        public static let navigationBarHeight: CGFloat = {
            return CGFloat(44)
        }()
    }
}

extension SycStruct where Base == CGFloat {
    /// 获取状态栏高度
    public static func getStatusBarHeight() -> CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
}
