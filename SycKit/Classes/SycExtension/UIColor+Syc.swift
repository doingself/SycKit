//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import UIKit

public extension SycStruct where Base: UIColor {
    /// 使用 RGB 创建颜色
    /// - 用法: UIColor.yc.getColor(r: 0, g: 0, b: 0, a: 1)
    static func build(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) -> UIColor {
        return UIColor.init(r: r, g: g, b: b, a: a)
    }
    
    /// 使用 十六进制 创建颜色
    /// - 用法: UIColor.yc.build(hexInt: 0xFFFFFF, alpha: 1)
    static func build(hexInt: Int, alpha: CGFloat = 1) -> UIColor {
        return UIColor.init(hexInt: hexInt, alpha: alpha)
    }
    
    /// 使用 十六进制字符串 创建颜色
    /// - 用法: UIColor.yc.build(hexString: "#FFFFFF", alpha: 1)
    static func build(hexString: String, alpha: CGFloat = 1) -> UIColor? {
        return UIColor.init(hexString: hexString, transparency: alpha)
    }
    
    /// 使用 十六进制字符串 创建颜色
    /// - 用法: UIColor.yc.build(light: "#FFFFFF", dark: nil)
    static func build(light:String, dark:String?) -> UIColor{
        return UIColor.init(light: light, dark: dark)
    }
    
    /// 当前颜色转换为图片
    /// - 用法: UIColor.red.yc.toImage()
    func toImage(size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        return base.toImage(size: size)
    }
}

// MARK: UIColor
extension UIColor {
    /*
     convenience: 便利，使用convenience修饰的构造函数叫做 便利构造函数
     便利构造函数 通常用在对 系统的类 进行构造函数的扩充时使用
     
     通常写在extension里面, 需要明确的调用self.init()
     */
    
    
    /// 使用 RGB 创建颜色
    /// - 用法: UIColor.init(r: 0, g: 0, b: 0, a: 1)
    /// - Parameters:
    ///   - r: 红
    ///   - g: 绿
    ///   - b: 蓝
    ///   - a: 透明度
    /// - Returns: UIColor
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
    
    /// 使用 十六进制 创建颜色
    /// - 用法: UIColor.init(hexInt: 0xFFFFFF, alpha: 1)
    /// - Parameters:
    ///   - hexInt: 十六进制
    ///   - alpha: 透明度
    /// - Returns: UIColor
    convenience init(hexInt: Int, alpha: CGFloat = 1) {
        // 转换 16 进制, 并位移
        let red = CGFloat((hexInt & 0xFF0000) >> 16)
        let green = CGFloat((hexInt & 0xFF00) >> 8)
        let blue = CGFloat(hexInt & 0xFF)
        
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    /// SwifterSwift: Create Color from hexadecimal string with optional transparency (if applicable).
    /// 使用 十六进制字符串 创建颜色
    /// - 用法: UIColor.init(hexString: "#FFFFFF", alpha: 1)
    /// - Parameters:
    ///   - hexString: 十六进制字符串 EDE7F6, 0xEDE7F6, #EDE7F6, #0ff, 0xF0F
    ///   - alpha: 透明度
    convenience init?(hexString: String, transparency: CGFloat = 1) {
        var string = ""
        if hexString.lowercased().hasPrefix("0x") {
            string = hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }
        
        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }
        
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        /*
         // 存储转换后的数值
         var color: UInt64 = 0
         let scanner = Scanner(string: hexColor)
         scanner.scanHexInt64(&color)
         let mask = 0x000000FF
         let red = (color >> 16) & mask
         let green = (color >> 8) & mask
         let blue = color & mask
         self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
         */
        
        guard let hexValue = Int(string, radix: 16) else {
            return nil
        }
        
        let mask = 0x000000FF
        let red = (hexValue >> 16) & mask
        let green = (hexValue >> 8) & mask
        let blue = hexValue & mask
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }
    
    /// 使用 十六进制字符串 创建颜色
    /// - 用法: UIColor.init(light: "#FFFFFF", dark: nil)
    convenience init(light:String, dark:String?) {
        let lightColor = UIColor(hexString: light) ?? UIColor.systemRed
        let darkColor: UIColor
        if let hex = dark {
            darkColor = UIColor(hexString: hex) ?? UIColor.systemRed
        } else {
            darkColor = lightColor
        }
        
        if #available(iOS 13.0, tvOS 13.0, *) {
            self.init(dynamicProvider: { $0.userInterfaceStyle == .dark ? darkColor : lightColor })
        } else {
            self.init(cgColor: lightColor.cgColor)
        }
    }
    
    /// 当前颜色转换为图片
    /// - 用法: UIColor.red.toImage()
    func toImage(size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        return UIImage.build(color: self, size: size)
    }
}
