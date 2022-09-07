//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import UIKit

public extension SycStruct where Base: Bundle {
    /// 版本 1.0
    static var versionValue: String? { Base.versionValue }
    /// 包名 xxx.xx.xx
    static var bundleIdValue: String? { Base.bundleIdValue }
    /// iOS
    static var systemNameValue: String { Base.systemNameValue }
    /// ios 版本 15.5
    static var systemVersionValue: String { Base.systemVersionValue }
}


extension Bundle {
    /// build 版本 1
    static var buildVersionValue: String? { Bundle.main.infoDictionary?["CFBundleVersion"] as? String }
    /// 版本 1.0
    static var versionValue: String? { Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String }
    /// 包名 xxx.xx.xx
    static var bundleIdValue: String? {
        //Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
        Bundle.main.bundleIdentifier
    }
    /// 应用名 xxx
    static var displayNameValue: String? { Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String }
    static var bundleNameValue: String? {
        //Bundle.main.infoDictionary?["CFBundleName"] as? String
        Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    /// xx的iPhone
    static var modelValue: String { UIDevice.current.model }
    /// iOS
    static var systemNameValue: String { UIDevice.current.systemName }
    /// ios 版本 15.5
    static var systemVersionValue: String { UIDevice.current.systemVersion }
}
