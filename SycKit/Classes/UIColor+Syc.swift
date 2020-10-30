//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import UIKit

extension SycStruct where Base: UIColor {
    /// RGB
    public static func getColor(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) -> UIColor {
        return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
    
    /// 十六进制字符串 转换 UIcolor
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
    
    /// Int 转换 UIcolor
    public static func getColor(hexInt: Int, alpha: CGFloat = 1) -> UIColor {
        // 转换 16 进制, 并位移
        let red = CGFloat(((hexInt & 0xFF0000) >> 16)) / CGFloat(255.0)
        let green = CGFloat(((hexInt & 0xFF00) >> 8)) / CGFloat(255.0)
        let blue = CGFloat(hexInt & 0xFF) / CGFloat(255.0)
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
