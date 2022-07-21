//
//  TabViewEditRowExampleViewController.swift
//  SycKit_Example
//
//  Created by swift-syc on 2020/12/23.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import SycKit

/// UITableView (编辑/索引)
class TabViewEditRowExampleViewController: UIViewController {
    
    private let tableView = UITableView()
    private let tabIndexDatas: [String] = ["a","e","i","o","u"]
    private var tabDatas: [[String]] = [
        ["a","a1","a2","a3","a4","a5"],
        ["e","e1","e2","e3","e4"],
        ["i","i1","i2","i3"],
        ["o","o1","o2","o3","o4"],
        ["u","u1","u1","u1","u1","u1","u1","u1","u1","u1","u1","u1","u1","u1","u1","u1","u1","u1"],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.title = "UITableView 编辑/索引"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(rightBarBtnItemAction))
        
        tableView.backgroundColor = UIColor.systemGray
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        // 索引
        // 设置索引值颜色
        tableView.sectionIndexColor = UIColor.systemBlue
        // 设置选中时的索引背景颜色
        tableView.sectionIndexTrackingBackgroundColor = UIColor.clear
        // 设置索引的背景颜色
        tableView.sectionIndexBackgroundColor = UIColor.clear
        
        self.view.addSubview(tableView)
        
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .always
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        UITableViewCell.yc.register(in: tableView)
        
        // iOS7 topLayoutGuide/bottomLayoutGuide
        // iOS9 UILayoutGuide
        // iOS11 Safe Area / safeAreaLayoutGuide
        
        tableView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                //make.edges.equalTo(self.view.safeAreaInsets) // never / always 都适配 iPhoneX
                make.edges.equalTo(self.view.safeAreaLayoutGuide) // never / always 都适配 iPhoneX
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
            //make.edges.equalTo(self.view.safeAreaInsets) // never / always 都适配 iPhoneX
            make.edges.equalTo(self.view.safeAreaLayoutGuide) // never / always 都适配 iPhoneX
            make.bottom.equalToSuperview() // always 时, 可以在 bottom 安全区域上显示
        }
    }
    
    /// rightBarBtnItem 事件
    @objc private func rightBarBtnItemAction(){
        var isEditing: Bool = tableView.isEditing
        isEditing.toggle()
        tableView.setEditing(isEditing, animated: true)
    }
}

// MARK: UITableViewDataSource
extension TabViewEditRowExampleViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tabDatas.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData: [String] = tabDatas[section]
        return sectionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionData: [String] = tabDatas[indexPath.section]
        let rowData: String = sectionData[indexPath.row]
        
        let cell = UITableViewCell.yc.dequeueReusableCell(in: tableView, for: indexPath)
        cell.textLabel?.text = "data: " + rowData
        return cell
    }
    
    // MARK: header / footer
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tabIndexDatas[section]
    }
    
    // MARK: index
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return tabIndexDatas
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        print("\(title) - \(index)")
        return index
    }
    
    // MARK: 单元格编辑
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // 前 2 组可编辑
        return indexPath.section < 2
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // 前 2 组可移动
        return indexPath.section < 2
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case UITableViewCell.EditingStyle.delete:
            // 删除
            var sectionData: [String] = self.tabDatas[indexPath.section]
            sectionData.remove(at: indexPath.row)
            self.tabDatas[indexPath.section] = sectionData
            
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        case .insert:
            break
        case .none:
            break
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        // 交换 sourceIndexPath <---> destinationIndexPath
        var sectionData: [String] = self.tabDatas[sourceIndexPath.section]
        let sourceData = sectionData[sourceIndexPath.row]
        sectionData[sourceIndexPath.row] = sectionData[destinationIndexPath.row]
        sectionData[destinationIndexPath.row] = sourceData
        self.tabDatas[sourceIndexPath.section] = sectionData
        
        tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
    }
}

extension TabViewEditRowExampleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // MARK: header / footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    // MARK: 删除 方式一
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除 del"
    }
    */
    
    // MARK: 删除 方式二 (覆盖方式一)
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let add = UITableViewRowAction(style: UITableViewRowAction.Style.normal, title: "add") { (action: UITableViewRowAction, indexPath: IndexPath) in
            print("\(#function) \(indexPath)")
        }
        let del = UITableViewRowAction(style: UITableViewRowAction.Style.default, title: "del") { (action: UITableViewRowAction, indexPath: IndexPath) in
            // 删除
            var sectionData: [String] = self.tabDatas[indexPath.section]
            sectionData.remove(at: indexPath.row)
            self.tabDatas[indexPath.section] = sectionData
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        return [add, del]
    }
}

