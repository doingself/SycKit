//
//  HomeViewController.swift
//  SycKit_Example
//
//  Created by swift-syc on 2020/12/22.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import SycKit

/// 原生组件/三方库 Snippets
class HomeViewController: UIViewController {
    
    private let tableView = UITableView()
    private let datas: [UIViewController.Type] = [
        HomeViewController.self,
        TabViewNormalViewController.self,
        TabViewEditRowExampleViewController.self,
        PresentStyleViewController.self,
        MJRefreshExampleViewController.self
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        //self.title = "原生组件/三方库 Snippets" // 会同时修改 tabbar title
        self.navigationItem.title = "原生组件/三方库 Snippets"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.camera, target: self, action: #selector(rightBarButtonItemAction))
        
        tableView.backgroundColor = UIColor.systemGray
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.rowHeight = UITableView.automaticDimension
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
    
    @objc private func rightBarButtonItemAction(){
        let vc = PresentStyleViewController()
        self.view.addSubview(vc.view)
        //self.present(vc, animated: true, completion: nil)
    }
}

// MARK: table delegate / datasource
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        let cell = UITableViewCell.yc.dequeueReusableCell(in: tableView, for: indexPath)
        cell.textLabel?.text = "\(data)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data: UIViewController.Type = datas[indexPath.row]
        let vc: UIViewController = data.init()
        
        if vc is PresentStyleViewController {
            self.present(vc, animated: true, completion: nil)
        } else {
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
