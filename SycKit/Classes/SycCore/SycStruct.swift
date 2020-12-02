//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

// 鸣谢 RxSwift https://github.com/ReactiveX/RxSwift
// 鸣谢 RxSwift Reactive.swift

// MARK: 泛型结构体
public struct SycStruct<Base> {
    public let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
}
