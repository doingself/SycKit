//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import UIKit

// 鸣谢 https://github.com/AliSoftware/Reusable

// MARK: UICollectionReusableView 处理

/// 扩展 UICollectionReusableView 方便 header/footer 注册获取
extension SycStruct where Base: UICollectionReusableView {
    
    /// cell Reuse Identifier
    private static var cellReuseIdentifier: String {
        get {
            let classStr = NSStringFromClass(Base.self)
            // 获取类名
            return classStr.components(separatedBy: ".").last!
        }
    }
    
    /// 注册 kind view
    /// - 用法: UICollectionReusableView.yc.register(in: collectionView, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader)
    /// - Parameters:
    ///   - collectionView: UICollectionView
    ///   - elementKind: UICollectionElementKindSectionHeader
    public static func register(in collectionView: UICollectionView, forSupplementaryViewOfKind elementKind: String) {
        collectionView.register(Base.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: cellReuseIdentifier)
    }
    
    /// 获取 kind view
    /// - 用法: let view = UICollectionReusableView.yc.dequeueReusableSupplementaryView(in: collectionView, ofKind: UICollectionElementKindSectionHeader, for: indexPath)
    /// - Parameters:
    ///   - collectionView: UICollectionView
    ///   - elementKind: UICollectionElementKindSectionHeader
    ///   - indexPath: IndexPath
    /// - Returns: UICollectionReusableView
    public static func dequeueReusableSupplementaryView(in collectionView: UICollectionView, ofKind elementKind: String, for indexPath: IndexPath) -> Base {
        return collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! Base
    }
}

// MARK: UICollectionView cell 处理

/// 扩展 UICollectionViewCell 方便 cell 注册获取
/// UICollectionViewCell 继承 UICollectionReusableView
extension SycStruct where Base: UICollectionViewCell {
    
    /// 注册 单元格
    /// - 用法: UICollectionViewCell.yc.register(in: collectionView)
    /// - Parameter collectionView: UICollectionView
    public static func register(in collectionView: UICollectionView) {
        collectionView.register(Base.self, forCellWithReuseIdentifier: cellReuseIdentifier)
    }
    
    /// 获取 单元格
    /// - 用法: let cell = UICollectionViewCell.yc.dequeueReusableCell(in: collectionView, for: indexPath)
    /// - Parameters:
    ///   - collectionView: UICollectionView
    ///   - indexPath: IndexPath
    /// - Returns: UICollectionViewCell
    public static func dequeueReusableCell(in collectionView: UICollectionView, for indexPath: IndexPath) -> Base {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! Base
    }
}
