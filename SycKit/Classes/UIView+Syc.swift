//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import UIKit

extension SycStruct where Base: UIView {
    
    /// 给 view 添加渐变色
    /// - Parameters:
    ///   - startColor: 渐变起始颜色
    ///   - endColor: 渐变最终颜色
    ///   - isHorizontal: 是否水平渐变
    public func addGradientLayer(startColor: UIColor, endColor: UIColor, isHorizontal: Bool = true){
        // CAGradientLayer 使用了硬件加速
        let gradientLayer = CAGradientLayer()
        
        //多大区域
        gradientLayer.frame = base.bounds
        //最后作为背景
        base.layer.insertSublayer(gradientLayer, at: 0)
        
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
}
