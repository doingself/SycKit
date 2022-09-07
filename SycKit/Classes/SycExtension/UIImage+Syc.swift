//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import UIKit

public extension SycStruct where Base: UIImage {
    /// 将颜色转换为图片
    /// - 用法: UIImage.yc.build(color: UIColor.red)
    static func build(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        return Base.build(color: color, size: size)
    }
    
    /**
     *  重设图片大小
     */
    func reSize(size: CGSize) -> UIImage? {
        return base.reSize(size: size)
    }
    
    /// 将图标改为指定颜色
    func withTintColorRenderingMode(content: UIView, tintColor: UIColor) -> UIImage {
        return base.withTintColorRenderingMode(content: content, tintColor: tintColor)
    }
}

extension UIImage {
    
    /// 将颜色转换为图片
    /// - 用法: UIImage.build(color: UIColor.red)
    static func build(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(origin: CGPoint.zero, size: size)
        
        // 开始绘图
        UIGraphicsBeginImageContext(rect.size)
        
        // 获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            // 结束绘图
            UIGraphicsEndImageContext()
            return nil
        }
        
        // 设置填充颜色
        context.setFillColor(color.cgColor)
        // 使用填充颜色填充区域
        context.fill(rect)
        
        // 获取绘制的图像
        let image = UIGraphicsGetImageFromCurrentImageContext()
        // 结束绘图
        UIGraphicsEndImageContext()
        
        return image
    }
    /**
     *  重设图片大小
     */
    func reSize(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// 将图标改为指定颜色
    func withTintColorRenderingMode(content: UIView, tintColor: UIColor) -> UIImage {
        if #available(iOS 13.0, *) {
            return self.withTintColor(tintColor, renderingMode: UIImage.RenderingMode.alwaysOriginal)
        } else {
            content.tintColor = tintColor
            return self.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        }
    }
}
