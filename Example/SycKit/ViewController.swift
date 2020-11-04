//
//  ViewController.swift
//  SycKit
//
//  Created by doingself@163.com on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import UIKit
import SycKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let v = UIView(frame: CGRect(x: 10, y: 100, width: 100, height: 100))
        // 添加渐变色
        v.yc.addGradientLayer(startColor: UIColor.yc.getColor(hexString: "#0061FF"), endColor: UIColor.red)
        self.view.addSubview(v)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

