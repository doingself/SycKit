//
//  PresentStyleViewController.swift
//  SycKit_Example
//
//  Created by swift-syc on 2020/12/24.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

/// 半透明 弹窗
class PresentStyleViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        
        // 半透明 设置
        
        //case coverVertical = 0 // 从底部升上来的方式
        //case flipHorizontal = 1 // 卡片翻转形式
        //case crossDissolve = 2 // 快速闪现
        //case partialCurl = 3 // 书本翻页效果
        self.modalTransitionStyle = .crossDissolve
        
        //case fullScreen = 0 //由下到上,全屏覆盖
        //case pageSheet = 1
        //case formSheet = 2
        //case currentContext = 3
        //case custom = 4
        //case overFullScreen = 5
        //case overCurrentContext = 6
        //case popover = 7
        //case none = -1
        //case automatic = -2
        self.modalPresentationStyle = .overFullScreen // 遮盖 tabbar
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapViewAction)))
        
        let contentView = UIView()
        contentView.backgroundColor = UIColor.systemTeal
        self.view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
    }
    
    @objc private func tapViewAction(){
        self.dismiss(animated: true, completion: nil)
    }
}
