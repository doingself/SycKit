//
//  PodExampleViewController.swift
//  SycKit_Example
//
//  Created by swift-syc on 2020/12/24.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import SycKit

/// SycKit 使用
class PodExampleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "SycKit 使用"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.camera, target: nil, action: nil)
        
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .always
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        colorExample()
        imageExample()
        printExample()
    }
}
extension PodExampleViewController {
    /// view 添加 渐变色
    /// 颜色初始化
    func colorExample(){
        let statusHeight = CGFloat.yc.statusBarHeight
        let navHeight = CGFloat.yc.navigationBarHeight
        let v = UIView(frame: CGRect(x: 4, y: statusHeight + navHeight + 4, width: 100, height: 50))
        
        // 初始化颜色
        guard let startColor = UIColor.yc.build(hexString: "#E1FFFF"),
              let endColor = UIColor.yc.build(hexString: "#F08080") else { return }
        
        // view 添加 渐变色
        v.yc.addGradientLayer(startColor: startColor, endColor: endColor)
        
        // 圆角
        v.yc.addCorner(corners: [UIRectCorner.topLeft, .bottomRight], radius: 10)
        
        self.view.addSubview(v)
    }
    func imageExample(){
        // 颜色转换图片
        let color = UIColor.yc.build(hexString: "#E1FFFF")!
        let image = UIImage.yc.build(color: color)
        
        let statusHeight = CGFloat.yc.statusBarHeight
        let navHeight = CGFloat.yc.navigationBarHeight
        let v = UIImageView(frame: CGRect(x: 114, y: statusHeight + navHeight + 4, width: 100, height: 50))
        
        v.image = image
        self.view.addSubview(v)
    }
    func printExample(){
        //let date = Date()
        //date.yc.startDay()
        let bundleIdValue = Bundle.yc.bundleIdValue!
        print("bundleName = \(bundleIdValue)")
    }
}
