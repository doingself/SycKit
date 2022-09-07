//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import UIKit

public extension SycStruct where Base: UILabel {
    /// 使文字左右两端对齐
    func textAlignmentLeftAndRightWith(text: String, width: CGFloat) {
        base.textAlignmentLeftAndRightWith(text: text, width: width)
    }
}


extension UILabel {
    /// 使文字左右两端对齐
    func textAlignmentLeftAndRightWith(text: String, width: CGFloat) {
        let font = font ?? UIFont.systemFont(ofSize: 14)
        var attrDic = [NSAttributedString.Key: Any]()
        attrDic.updateValue(font, forKey: NSAttributedString.Key.font)
        
        let size = text.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin, .truncatesLastVisibleLine, .usesFontLeading], attributes: attrDic, context: nil).size
        
        let length = text.count - 1
        let margin = (width - size.width) / CGFloat(length)
        
        let number = NSNumber(floatLiteral: Double(margin))
        let attribute = NSMutableAttributedString.init(string: text as String)
        attribute.addAttribute(.font, value: font, range: NSRange(location: 0, length: length))
        attribute.addAttribute(.kern, value: number, range:NSRange(location: 0, length: length))
        self.attributedText = attribute;
    }
}
