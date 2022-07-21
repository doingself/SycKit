//
//  NetworkError.swift
//  SycKit
//
//  Created by cityfruit on 2022/6/2.
//

import Foundation
import Moya

/// 网络错误
enum NetworkError: Error {
    // 服务器错误 500~599
    case serverBlast
    // 404
    case notFound
    // 401
    case notAuth
    // 业务异常，含有 responseData，返回内容为对应错误信息
    case detail(code: Int, info: String)
    // 错误的JSON格式
    case errorJSON
    // 解析错误
    case mapError(error: Error)
    // 网络环境问题
    case otherError(error: Error)
}

extension NetworkError {
    var localizedDescription: String {
        switch self {
        case .serverBlast:
            return "服务器报错"
        case .notFound:
            return "接口地址错误"
        case .notAuth:
            return "认证信息已过期"
        case let .detail(_, info: info):
            return info
        case .errorJSON:
            return "JSON错误"
        case let .mapError(error: error):
            return "模型转换失败 \n \(error)"
        case let .otherError(error: error):
            if let err = error as? MoyaError, case .underlying = err {
                return "无法连接服务器"
            }
            return error.localizedDescription
            // 网络环境问题
//            return "无法连接网络，请检查网络设置 \(error.localizedDescription)"
        }
    }
}

