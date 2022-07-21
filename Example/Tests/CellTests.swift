//
//  CellTests.swift
//  SycKit_Tests
//
//  Created by swift-syc on 2020/11/10.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import SycKit
@testable import SycKit_Example

class CellTests: XCTestCase {
    /// table view
    private var tableView: UITableView!
    
    /// collection view
    private var collectionView: UICollectionView!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
        tableView = UITableView()
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        defer{
            super.tearDown()
        }
        tableView = nil
        collectionView = nil
    }

    func testUITableViewCell() throws {
        
        // 注册 cell
        UITableViewCell.yc.register(in: tableView)
        
        // 这是一个 IndexPath
        let indexPath = IndexPath(row: 0, section: 0)
        
        // 获取 cell
        let cell = UITableViewCell.yc.dequeueReusableCell(in: tableView, for: indexPath)
        print(cell)
    }
    
    func testUICollectionViewCell() throws {
        
        // 注册 cell
        UICollectionViewCell.yc.register(in: collectionView)
        UICollectionReusableView.yc.register(in: collectionView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        
        // 这是一个 IndexPath
        let indexPath = IndexPath(item: 0, section: 0)
        
        // 获取 cell / header
        let cell = UICollectionViewCell.yc.dequeueReusableCell(in: collectionView, for: indexPath)
        let view = UICollectionReusableView.yc.dequeueReusableSupplementaryView(in: collectionView, ofKind: UICollectionView.elementKindSectionHeader, for: indexPath)
        
        print(cell)
        print(view)
    }
}
