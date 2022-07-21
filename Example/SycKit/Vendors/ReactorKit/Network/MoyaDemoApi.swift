//
//  FeedbackViewModel.swift
//  SycKit
//
//  Created by syc on 2022/7/20.
//

import Foundation
import Moya

extension NetworkApi {
    enum MoyaDemoApi{
        case list(page: Int, size: Int)
        case detail(id: Int)
        case update(id: Int, name: String)
    }
}

extension NetworkApi.MoyaDemoApi: TargetType {
    var baseURL: URL {
        return NetworkApi.activeBaseURL
    }
    
    var path: String {
        switch self {
        case .list:
            return "/xxx/list"
        case .detail:
            return "/xxx/detail"
        case .update:
            return "/xxx/update"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .detail:
            return Moya.Method.get
        default:
            return Moya.Method.post
        }
    }
    
    var task: Task {
        var params: [String: Any] = NetworkApi.parameters
        switch self {
        case let .list(page, size):
            params["page"] = page
            params["size"] = size
            return Task.requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .detail(id):
            params["id"] = id
            return Task.requestParameters(parameters: params, encoding: URLEncoding.default)
        case let .update(id, name):
            params["id"] = id
            params["name"] = name
            return Task.requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return NetworkApi.header
    }
    
    var validationType: ValidationType {
        return ValidationType.none
    }

    var sampleData: Data {
        return Data()
    }
}
