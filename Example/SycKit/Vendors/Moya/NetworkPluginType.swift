//
//  NetworkPluginType.swift
//  SycKit
//
//  Created by cityfruit on 2022/6/2.
//

import Foundation
import Moya

enum NetworkPluginType {}

// MARK: 权限认证插件
extension NetworkPluginType {
    /// 权限认证插件
    struct AuthPlugin: PluginType {
        
        let authorizationClosure: () -> String?
        
        func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
            
            guard let token = authorizationClosure() else {
                return request
            }
            
            // 在请求中添加头部验证信息
            var request = request
            request.addValue(token, forHTTPHeaderField: "Authorization")
            return request
        }
    }
}

// MARK: HUD 插件
extension NetworkPluginType {
    /// HUD 插件
    class HUDPlugin: PluginType {
        
        func willSend(_ request: RequestType, target: TargetType) {
            HUD.show()
        }
        
        func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
            HUD.hide()
        }
    }
}
