//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import UIKit

extension SycStruct where Base == String {

    /// 获取字符串的 size
    /// - Parameters:
    ///   - attributes: [NSAttributedString.Key : Any]
    ///   - maxWidth: 最大宽 CGFloat
    ///   - maxHeight: 最大高 CGFloat
    /// - Returns: CGSize
    public func sizeWithAttributes(attributes : [NSAttributedString.Key : Any], maxWidth: CGFloat?, maxHeight: CGFloat?) -> CGSize {
        guard base.isEmpty == false else {
            return CGSize.zero
        }
        let width = maxWidth ?? CGFloat.infinity
        let height = maxHeight ?? CGFloat.infinity
        let size = CGSize(width: width, height: height)
        let text = base as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        return rect.size
    }
}
