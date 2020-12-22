//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import UIKit

/*
NSFontAttributeName               设置字体大小和字体的类型 默认12 Helvetica(Neue)
NSForegroundColorAttributeName    设置字体颜色，默认黑色 UIColor对象
NSBackgroundColorAttributeName    设置字体所在区域的背景颜色，默认为nil，透明色
NSLigatureAttributeName           设置连体属性，NSNumber对象 默认0 没有连体
NSKernAttributeName               设置字符间距， NSNumber浮点型属性 正数间距加大，负数间距缩小
NSStrikethroughStyleAttributeName 设置删除线，NSNumber对象
NSStrikethroughColorAttributeName 设置删除线颜色，UIColor对象，默认是黑色
NSUnderlineStyleAttributeName     设置下划线，NSNumber对象 NSUnderlineStyle枚举值
NSUnderlineColorAttributeName     设置下划线颜色，UIColor对象，默认是黑色
NSStrokeWidthAttributeName        设置笔画宽度，NSNumber对象 正数中空 负数填充
NSStrokeColorAttributeName        设置填充部分颜色，不是指字体颜色，UIColor对象
NSShadowAttributeName             设置阴影属性，取值为NSShadow对象
NSTextEffectAttributeName         设置文本特殊效果 NSString对象 只有图版印刷效果可用
NSBaselineOffsetAttributeName     设置基线偏移量，NSNumber float对象 正数向上偏移，负数向下偏移
NSObliquenessAttributeName        设置字体倾斜度，NSNumber float对象，正数右倾斜，负数左倾斜
NSExpansionAttributeName          设置文本横向拉伸属性，NSNumber float对象，正数横向拉伸文本，负数压缩
NSWritingDirectionAttributeName   设置文字书写方向，从左向右或者右向左
NSVerticalGlyphFormAttributeName  设置文本排版方向，NSNumber对象。0 横向排版，1 竖向排版
NSLinkAttributeName               设置文本超链接，点击可以打开指定URL地址
NSAttachmentAttributeName         设置文本附件，取值为NSTextAttachment对象，一般为图文混排
NSParagraphStyleAttributeName     设置文本段落排版，为NSParagraphStyle对象
*/

extension SycStruct where Base: NSAttributedString {
    
    /// 获取 NSAttributedString 字符串的 size
    /// - Parameters:
    ///   - attributes: [NSAttributedString.Key : Any]
    ///   - maxWidth: 最大宽 CGFloat
    ///   - maxHeight: 最大高 CGFloat
    /// - Returns: CGSize
    func sizeWithAttributes(attributes : [NSAttributedString.Key : Any], maxWidth: CGFloat?, maxHeight: CGFloat?) -> CGSize {
        
        /*
        let mulPara = NSMutableParagraphStyle()
        let attrs = [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: mulPara]
        let attrString = NSAttributedString(string: text, attributes: attrs)
        var rect = attrString.boundingRect(with: CGSize(width: 11, height: 22), options: .usesLineFragmentOrigin, context: nil)
        rect.size
        */
        let attributedString: NSAttributedString = base
        let width = maxWidth ?? CGFloat.infinity
        let height = maxHeight ?? CGFloat.infinity
        let size = CGSize(width: width, height: height)
        let rect = attributedString.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        return rect.size
    }

}


extension SycStruct where Base: NSMutableAttributedString {
    

}
