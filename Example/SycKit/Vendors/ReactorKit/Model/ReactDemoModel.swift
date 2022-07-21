//
//  FeedbackViewModel.swift
//  SycKit
//
//  Created by syc on 2022/7/20.
//

import Foundation
import RxDataSources

struct ReactDemoModel: Codable, IdentifiableType, Equatable {
    // MARK: IdentifiableType
    typealias Identity = Int
    var identity : Identity {
        return id ?? 0
    }
    
    // MARK: Equatable
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identity == rhs.identity
    }
    
    let id: Int?
    var name: String?
}

/**
 - 系统: SectionModel<String, ReactDemoModel>
 - 自定义: ReactDemoSectionModel
 */
struct ReactDemoSectionModel {
    var items: [Item]
    var header: String
}

extension ReactDemoSectionModel: AnimatableSectionModelType {
    typealias Item = ReactDemoModel
    
    typealias Identity = String
    var identity: String { return header }
    
    init(original: ReactDemoSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
    
    init(header: String, items: [Item]) {
        self.header = header
        self.items = items
    }
}

