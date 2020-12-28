//
//  MJRefreshExampleViewController.swift
//  SycKit_Example
//
//  Created by swift-syc on 2020/12/23.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh
import SycKit

/// MJRefresh Demo
class MJRefreshExampleViewController: UIViewController {
    
    private let tableView = UITableView()
    private var datas: [Int] = [1,2,3,4,5,6,7,8,9]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.title = "MJRefresh"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.camera, target: nil, action: nil)
        
        tableView.backgroundColor = UIColor.systemGray
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .always
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        UITableViewCell.yc.register(in: tableView)
        
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
        
        let refreshNormalHeader = MJRefreshNormalHeader(refreshingBlock: {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.datas = [1,2,3,4,5,6,7,8,9]
                // 结束刷新
                self.tableView.mj_header?.endRefreshing()
                // 重置 footer
                self.tableView.mj_footer?.resetNoMoreData()
                self.tableView.reloadData()
            }
        })
        refreshNormalHeader.setTitle("下拉刷新 idle", for: MJRefreshState.idle)
        refreshNormalHeader.setTitle("松开刷新 pulling", for: MJRefreshState.pulling)
        refreshNormalHeader.setTitle("正在刷新 refreshing", for: MJRefreshState.refreshing)
        tableView.mj_header = refreshNormalHeader
        
        let refreshAutoNormalFooter = MJRefreshAutoNormalFooter(refreshingBlock: {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.datas += [1,2,3,4,5,6,7,8,9]
                if self.datas.count > 20 {
                    // 结束刷新, 并没有数据了
                    self.tableView.mj_footer?.endRefreshingWithNoMoreData()
                } else {
                    self.tableView.mj_footer?.endRefreshing()
                }
                self.tableView.reloadData()
            }
        })
        refreshAutoNormalFooter.setTitle("上拉刷新 idle", for: MJRefreshState.idle)
        refreshAutoNormalFooter.setTitle("松开刷新 pulling", for: MJRefreshState.pulling)
        refreshAutoNormalFooter.setTitle("正在刷新 refreshing", for: MJRefreshState.refreshing)
        refreshAutoNormalFooter.setTitle("即将刷新 willRefresh", for: MJRefreshState.willRefresh)
        refreshAutoNormalFooter.setTitle("加载完了 noMoreData", for: MJRefreshState.noMoreData)
        tableView.mj_footer = refreshAutoNormalFooter
        
        tableView.mj_header?.beginRefreshing()
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

extension MJRefreshExampleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        let cell = UITableViewCell.yc.dequeueReusableCell(in: tableView, for: indexPath)
        cell.textLabel?.text = "data: \(data)"
        return cell
    }
}
