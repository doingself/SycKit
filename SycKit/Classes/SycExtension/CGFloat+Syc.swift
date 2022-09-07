//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import UIKit

public extension SycStruct where Base == CGFloat {
    var stringValue: String {
        return base.stringValue
    }
    
    static var statusBarHeight: CGFloat {
        return Base.statusBarHeight
    }
    
    static var navigationBarHeight: CGFloat {
        return Base.navigationBarHeight
    }
}

extension CGFloat {
    var stringValue: String {
        return "\(self)"
    }
    
    static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    static var navigationBarHeight: CGFloat {
        return CGFloat(44)
    }
}
