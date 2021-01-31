//
//  ReactorKitDemoModel.swift
//  SycKit_Example
//
//  Created by syc on 2021/1/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import RxDataSources

struct ReactorKitDemoModel {
    var selected: Bool = false
    let title: String?
}

struct ReactorKitDemoSection {
    var items: [Item]
    var header: String
}

extension ReactorKitDemoSection: AnimatableSectionModelType {
    typealias Item = ReactorKitDemoModel
    
    typealias Identity = String
    var identity: String { return header }
    
    init(original: ReactorKitDemoSection, items: [Item]) {
        self = original
        self.items = items
    }
    
    init(header: String, items: [Item]) {
        self.header = header
        self.items = items
    }
}

