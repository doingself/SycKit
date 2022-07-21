//
//  NetworkApi.swift
//  SycKit
//
//  Created by cityfruit on 2022/6/2.
//

import Foundation
import UIKit

enum NetworkApi {}

// MARK: 运行环境
extension NetworkApi {
    enum Environment: String, CaseIterable {
        case appStore // 正式环境
        case develop // 开发环境
        
        var baseURL: URL {
            switch self {
            case .appStore:
                return URL(string: "http://localhost:8080")!
            case .develop:
                return URL(string: "http://localhost:8080")!
            }
        }
    }
}

fileprivate let activeKey = "ActiveEnvironment"
extension NetworkApi {
    /// 配置环境
    static func configActive(evn: NetworkApi.Environment){
        UserDefaults.standard.setValue(evn.rawValue, forKey: activeKey)
    }
    
    /// 当前环境
    static var activeEnvironment: NetworkApi.Environment {
        if let envStr = UserDefaults.standard.string(forKey: activeKey),
           let env = Environment(rawValue: envStr) {
            return env
        } else {
            // 默认正式环境
            return  Environment.appStore
        }
    }
    /// 当前环境 url
    static var activeBaseURL: URL {
        return NetworkApi.activeEnvironment.baseURL
    }
    
}

// MARK: 公共参数
extension NetworkApi{
    
    /// 公共参数
    static let header: [String: String] = [
        //"Content-Type": "application/json",
        "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8",
        "model": UIDevice.current.model,
        "systemName": UIDevice.current.systemName,
        "systemVersion": UIDevice.current.systemVersion,
        "bundle": (Bundle.main.bundleIdentifier ?? "Unknown"),
        "bundleId": (Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? "Unknown"),
        "bundleName": (Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "Unknown"),
        "build": (Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"),
        "buildShort": (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"),
        "activeEnv": NetworkApi.activeEnvironment.rawValue,
    ]
    
    static let parameters: [String: Any] = [
        "deviceId": UIDevice.current.keychainIDFV, // 新的设备ID
    ]
}
