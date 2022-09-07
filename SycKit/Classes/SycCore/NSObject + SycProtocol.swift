//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

// 鸣谢 RxSwift https://github.com/ReactiveX/RxSwift
// 鸣谢 RxSwift Reactive.swift

import class Foundation.NSObject

// MARK: NSObject 继承 SycProtocol 协议后, NSObject 可以使用 `yc`
extension NSObject: SycProtocol { }

// MARK: String 继承 SycProtocol 协议后 可以使用 `yc`
extension String: SycProtocol { }

// MARK: Int 继承 SycProtocol 协议后 可以使用 `yc`
extension Int: SycProtocol { }

// MARK: CGFloat 继承 SycProtocol 协议后 可以使用 `yc`
extension CGFloat: SycProtocol { }

// MARK: Data 继承 SycProtocol 协议后 可以使用 `yc`
extension Data: SycProtocol { }
