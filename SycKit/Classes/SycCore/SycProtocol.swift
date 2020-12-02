//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

// 鸣谢 RxSwift https://github.com/ReactiveX/RxSwift
// 鸣谢 RxSwift Reactive.swift

// MARK: 协议
public protocol SycProtocol {
    // 定义一个协议时，有的时候声明一个或多个关联类型作为协议定义的一部分
    // 关联类型为协议中的某个类型提供了一个占位名（或者说别名），其代表的实际类型在协议被采纳时才会被指定。
    // 通过 associatedtype 关键字来指定关联类型，具体表示的类型要在最终使用的时候用 typealias 进行赋值
    associatedtype SycAssociatedtype
    
    // typealias 是用来为已经存在的类型重新定义名字的
    // deprecated 指定平台从哪一版本开始弃用该声明。
    // renamed 用以表示被重命名的声明的新名字。当使用声明的旧名字时，编译器会报错提示新名字
    @available(*, deprecated, renamed: "SycAssociatedtype")
    typealias SycTypealias = SycAssociatedtype
    
    /// 静态变量
    static var yc: SycStruct<SycAssociatedtype>.Type { get set }
    
    /// 实例变量
    var yc: SycStruct<SycAssociatedtype> { get set }
}

extension SycProtocol {
    public static var yc: SycStruct<Self>.Type {
        get {
            return SycStruct<Self>.self
        }
        set { }
    }
    
    public var yc: SycStruct<Self> {
        get {
            return SycStruct(self)
        }
        set { }
    }
}
