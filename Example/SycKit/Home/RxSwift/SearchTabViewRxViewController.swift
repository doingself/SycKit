//
//  SearchTabViewRxViewController.swift
//  SycKit_Example
//
//  Created by syc on 2021/1/4.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import RxDataSources
import SnapKit

/// rx 实时搜索 table view (Rx + RxDataSources)
class SearchTabViewRxViewController: UIViewController {
    
    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.title = "RxSwift search UITableView"
        
        self.view.addSubview(searchBar)
        
        tableView.backgroundColor = UIColor.systemGray
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        
        UITableViewCell.yc.register(in: tableView)
        
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .always
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        let searchSize = searchBar.sizeThatFits(CGSize.zero)
        searchBar.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.left.right.equalTo(self.view.safeAreaLayoutGuide)
            } else {
                make.top.equalTo(self.topLayoutGuide.snp.bottom)
                make.left.right.equalToSuperview()
            }
            make.height.equalTo(searchSize.height)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom)
            if #available(iOS 11.0, *) {
                make.left.right.equalTo(self.view.safeAreaLayoutGuide)
                make.bottom.equalToSuperview()
            } else {
                make.left.right.equalToSuperview()
                make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
            }
        }
        
        // rx
        setupTabViewRx()
    }
}

extension SearchTabViewRxViewController {
    func setupTabViewRx(){
        // 数据
        let items = Observable.just([
            SectionModel(model: "我喜欢的语言", items: [
                            "C++",
                            "C",
                            "Swift",
                            "Go",
                            "Java"]),
            SectionModel(model: "我讨厌的语言", items: [
                "Objective-C",
                "C#",
            ])
        ])
        
        
        
        // 数据源
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>> { (dataSource: TableViewSectionedDataSource<SectionModel<String, String>>, tableView: UITableView, indexPath: IndexPath, item: TableViewSectionedDataSource<SectionModel<String, String>>.Item) -> UITableViewCell in
            let cell = UITableViewCell.yc.dequeueReusableCell(in: tableView, for: indexPath)
            cell.textLabel?.text = "\(indexPath.row): \(item)"
            cell.accessoryType = .detailButton
            return cell
        }
        
        // 设置分区的头标题
        dataSource.titleForHeaderInSection = {
            ds, index in
            return ds.sectionModels[index].model
        }
        
        // 数据绑定
        items.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        //获取选中项的索引
        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("选中项的indexPath为：\(indexPath)")
        }).disposed(by: rx.disposeBag)
         
        //获取选中项的内容
        tableView.rx.modelSelected(String.self).subscribe(onNext: { item in
            print("选中项的标题为：\(item)")
        }).disposed(by: rx.disposeBag)
        
        // 同时获取选中项的索引及内容
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(String.self))
            .bind { indexPath, item in
                print("zip 选中项的indexPath为：\(indexPath), 选中项的标题为：\(item)")
            }.disposed(by: rx.disposeBag)
        
        //tableviewcell中的点击感叹号
        tableView.rx.itemAccessoryButtonTapped.subscribe(onNext: { indexPath in
            print("详情===\(indexPath.row)")
        }).disposed(by: rx.disposeBag)
    }
}
