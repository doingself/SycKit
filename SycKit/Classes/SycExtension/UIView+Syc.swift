//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import UIKit
import QuartzCore

public extension SycStruct where Base: UIView {
    /// 获取 控件高度
    var heightToFit: CGFloat { base.heightToFit }
    
    /// 给 view 添加渐变色
    /// - 用法: view.yc.addGradientLayer(startColor: .red, endColor: .green, isHorizontal: true)
    /// - Parameters:
    ///   - startColor: 渐变起始颜色
    ///   - endColor: 渐变最终颜色
    ///   - isHorizontal: 是否水平渐变
    func addGradientLayer(startColor: UIColor, endColor: UIColor, isHorizontal: Bool = true) {
        base.addGradientLayer(startColor: startColor, endColor: endColor, isHorizontal: isHorizontal)
    }
    
    /// 圆角
    func addCorner(corners: UIRectCorner , radius: CGFloat) {
        base.addCorner(corners: corners, radius: radius)
    }
    
    /// 边框
    func addBorder(corners: UIRectCorner , radius: CGFloat, strokeColor: UIColor) {
        base.addBorder(corners: corners, radius: radius, strokeColor: strokeColor)
    }
}

extension UIView {
    /// 获取 控件高度
    var heightToFit: CGFloat {
        self.setNeedsLayout()
        self.layoutIfNeeded()
        return self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    }
    
    /// 给 view 添加渐变色
    /// - 用法: view.yc.addGradientLayer(startColor: .red, endColor: .green, isHorizontal: true)
    /// - Parameters:
    ///   - startColor: 渐变起始颜色
    ///   - endColor: 渐变最终颜色
    ///   - isHorizontal: 是否水平渐变
    func addGradientLayer(startColor: UIColor, endColor: UIColor, isHorizontal: Bool = true){
        // CAGradientLayer 使用了硬件加速
        let gradientLayer = CAGradientLayer()
        
        //多大区域
        gradientLayer.frame = self.bounds
        //最后作为背景
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        //颜色数组，定义渐变层的各个颜色
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        // 决定每个渐变颜色的终止位置，这些值必须是递增的，数组的长度和 colors 的长度最好一致
        // 0.0代表着渐变的开始，1.0代表着结束。
        gradientLayer.locations = [0.2, 1.0]
        if isHorizontal {
            // 水平渐变
            //渲染的起始位置 左上角坐标是{0, 0}，右下角坐标是{1, 1}，默认值是：[.5,0]
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
            //渲染的终止位置 左上角坐标是{0, 0}，右下角坐标是{1, 1}，默认值是：[.5,1]
            gradientLayer.endPoint  = CGPoint.init(x: 1, y: 0)
        } else {
            // 垂直渐变
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
            gradientLayer.endPoint  = CGPoint.init(x: 0, y: 1)
        }
        
        // 给 label 添加文字渐变
        //gradientLayer.mask = label.layer
    }
    
    /// 部分圆角
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radius: 圆角半径
    func addCorner(corners: UIRectCorner , radius: CGFloat) {
        let view: UIView = self
        
        let maskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = maskPath.cgPath
        view.layer.mask = maskLayer
    }
    
    /// 边框
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radius: 圆角半径
    func addBorder(corners: UIRectCorner , radius: CGFloat, strokeColor: UIColor) {
        let view: UIView = self
        
        let maskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = view.bounds
        shapeLayer.path = maskPath.cgPath
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(shapeLayer)
    }
}
