//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import UIKit

extension SycStruct where Base: UIColor {
    
    /// 使用 RGB 创建颜色
    /// - 用法: UIColor.yc.getColor(r: 0, g: 0, b: 0, a: 1)
    /// - Parameters:
    ///   - r: 红
    ///   - g: 绿
    ///   - b: 蓝
    ///   - a: 透明度
    /// - Returns: UIColor
    public static func getColor(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) -> UIColor {
        return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
    
    /// 使用 十六进制字符串 创建颜色
    /// - 用法: UIColor.yc.getColor(hexString: "#FFFFFF", alpha: 1)
    /// - Parameters:
    ///   - hexString: 十六进制字符串
    ///   - alpha: 透明度
    /// - Returns: UIColor
    public static func getColor(hexString: String, alpha: CGFloat = 1) -> UIColor {
        let hexColor = hexString.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hexColor)
        // 存储转换后的数值
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// 使用 十六进制 创建颜色
    /// - 用法: UIColor.yc.getColor(hexInt: 0xFFFFFF, alpha: 1)
    /// - Parameters:
    ///   - hexInt: 十六进制
    ///   - alpha: 透明度
    /// - Returns: UIColor
    public static func getColor(hexInt: Int, alpha: CGFloat = 1) -> UIColor {
        // 转换 16 进制, 并位移
        let red = CGFloat(((hexInt & 0xFF0000) >> 16)) / CGFloat(255.0)
        let green = CGFloat(((hexInt & 0xFF00) >> 8)) / CGFloat(255.0)
        let blue = CGFloat(hexInt & 0xFF) / CGFloat(255.0)
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
