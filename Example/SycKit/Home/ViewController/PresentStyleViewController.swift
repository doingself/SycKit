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
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overCurrentContext
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
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
