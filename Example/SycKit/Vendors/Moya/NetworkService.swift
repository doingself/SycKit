//
//  NetworkService.swift
//  SycKit
//
//  Created by cityfruit on 2022/6/2.
//

import Foundation
import ReactorKit

// MARK: Service
class NetworkService {
    private init() {}
    
    static let shared = NetworkService()
    
    public lazy var provider = NetworkProvider(plugins: [
        NetworkPluginType.AuthPlugin(authorizationClosure: { [weak self] () -> String? in
            return "token"
        }), // 权限认证
        NetworkPluginType.HUDPlugin() // hud
    ])

}


// MARK: ReactorKit
extension Reactor {
    var networkService: NetworkService {
        return NetworkService.shared
    }
}
