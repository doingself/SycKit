//
//  AppColor.swift
//  SycKit_Example
//
//  Created by jiuan on 2022/9/7.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

enum AppColor {
    /// UIColor.clear
    static let clear = UIColor.clear
    static let white = UIColor.yc.build(light: "#FFFFFF", dark: "#000000")
    // A present B,
    // 那么 A.presentedViewController = B;
    // B.presentingViewController = A;
    static let presentedBlackground = UIColor.init(white: 0.4, alpha: 0.6)
    
    
}
