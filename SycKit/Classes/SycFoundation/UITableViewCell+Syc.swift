//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import UIKit

// 鸣谢 https://github.com/AliSoftware/Reusable

/// 扩展 UITableViewCell 方便 cell 注册获取
extension SycStruct where Base: UITableViewCell {
    
    /// cell Reuse Identifier
    private static var cellReuseIdentifier: String {
        get {
            let classStr = NSStringFromClass(Base.self)
            // 获取类名
            return classStr.components(separatedBy: ".").last!
        }
    }

    /// 注册 cell
    /// - 用法: UITableViewCell.yc.register(in: tableView)
    /// - Parameter tableView: UITableView
    public static func register(in tableView: UITableView) {
        tableView.register(Base.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    /// 获取 cell
    /// - 用法: let cell = UITableViewCell.yc.dequeueReusableCell(in: tableView, for: indexPath)
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: IndexPath
    /// - Returns: UITableViewCell
    public static func dequeueReusableCell(in tableView: UITableView, for indexPath: IndexPath) -> Base {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? Base {
            // 已注册 cell
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? Base {
            // 未注册 cell
            return cell
        } else {
            // 创建 cell
            let cell = Base(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellReuseIdentifier)
            return cell
        }
    }
}
