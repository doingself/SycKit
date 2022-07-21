//
//  TabViewNormalViewController.swift
//  SycKit_Example
//
//  Created by swift-syc on 2020/12/24.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import SycKit

/// 纯 UITableView
class TabViewNormalViewController: UIViewController {
    
    private let tableView = UITableView()
    private let datas: [Any] = [
        1,2,3,4,5,6,7,8
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.title = "UITableView"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.camera, target: nil, action: nil)
        
        tableView.backgroundColor = UIColor.systemGray
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        
        UITableViewCell.yc.register(in: tableView)
        
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .always
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        tableView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(self.view.safeAreaLayoutGuide)
                make.bottom.equalToSuperview()
            } else {
                make.top.equalTo(self.topLayoutGuide.snp.bottom)
                make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
                make.left.right.equalToSuperview()
            }
        }
    }
    
    /// 安全区域发生变化
    @available(iOS 11.0, *)
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        tableView.snp.remakeConstraints { (make) in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: table delegate / datasource
extension TabViewNormalViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        let cell = UITableViewCell.yc.dequeueReusableCell(in: tableView, for: indexPath)
        cell.textLabel?.text = "\(data)"
        cell.detailTextLabel?.text = "\(indexPath.section)-\(indexPath.row)"
        cell.selectionStyle = .gray
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

