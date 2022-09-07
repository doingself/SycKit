//
//  NetworkProvider.swift
//  SycKit
//
//  Created by cityfruit on 2022/6/2.
//

import Foundation
import Moya
import RxSwift

typealias JSONResponse = [String: Any]

// MARK: provider
class NetworkProvider: MoyaProvider<MultiTarget> {
    /// 实例化 Provider
    init(plugins: [PluginType]) {
        let session = MoyaProvider<MultiTarget>.defaultAlamofireSession()
        session.sessionConfiguration.timeoutIntervalForRequest = 20
        
        super.init(session: session, plugins: plugins)
    }
}



// MARK: - MoyaProvider

extension MoyaProvider {
    /// 用于处理返回值 Result 为 nil 的请求
    ///
    /// - Parameter target: 请求目标
    /// - Returns: 请求结果
    func requestResult(_ target: Target) -> Completable {
        request(target).asCompletable()
    }
    
    /// 用于处理返回值为 string 的请求
    ///
    /// - Parameter target: 请求目标
    /// - Returns: json对象
    func requestString(_ target: Target) -> Single<String> {
        request(target).flatMap { obj -> Single<String> in
            if let str = obj as? String {
                return Single.just(str)
            } else if let num = obj as? Int {
                return Single.just(num.yc.stringValue)
            } else {
                return Single.just("")
            }
        }
    }
    
    /// 用于处理请求非集合类型，可以调用 mapObject 方法进行 Model 转换
    ///
    /// - Parameter target: 请求目标
    /// - Returns: json对象
    func requestObjectJson(_ target: Target) -> Single<JSONResponse> {
        request(target).flatMap { json -> Single<JSONResponse> in
            // swiftlint:disable force_cast
            //.just(json as! JSONResponse)
            if let list = json as? JSONResponse {
                return Single.just(list)
            } else {
                return Single.just(JSONResponse())
            }
        }
    }
    
    ///  用于处理请求集合类型，可以调用 mapArray 方法进行 Model 转换
    ///
    /// - Parameter target: 请求目标
    /// - Returns: json数组对象
    func requestArrayJson(_ target: Target, keyPath: String? = nil) -> Single<[JSONResponse]> {
        request(target).flatMap { json -> Single<[JSONResponse]> in
            // swiftlint:disable force_cast
            //.just(json as! [JSONResponse])
            if let keyPath = keyPath,
               let dict = json as? JSONResponse,
               let list = dict[keyPath] as? [JSONResponse] {
                    return Single.just(list)
            }
            if let list = json as? [JSONResponse] {
                return Single.just(list)
            } else {
                return Single.just([])
            }
        }
    }
}

private extension MoyaProvider {
    /// 请求数据
    ///
    /// - Parameter target: 请求目标
    /// - Returns: json数组或对象数据
    private func request(_ target: Target) -> Single<Any?> {
        rx.request(target)
            .do(onSuccess: { (resp: Response) in
                var info = "==== request success ==== \n"
                if let url = resp.request?.url?.absoluteString {
                    info += " url: \(url) \n"
                }
                if let header = resp.request?.allHTTPHeaderFields {
                    info += " header: \(header) \n"
                }
                if let body = resp.request?.httpBody, let jsonStr = String(data: body, encoding: String.Encoding.utf8) {
                    info += " httpBody: \(jsonStr) \n"
                }
                info += " response: \(resp.debugDescription) \n"
                if let jsonStr = String(data: resp.data, encoding: String.Encoding.utf8) {
                    info += " data: \(jsonStr) \n"
                }
                print(info)
            }, onError: nil, onSubscribe: nil, onSubscribed: nil, onDispose: nil)
            .filterSuccessfulStatusAndRedirectCodes()
            .mapJSON()
            .flatMap { json -> Single<Any?> in
                let data = json as! JSONResponse
                guard let ret = data["ret"] as? String, let code = Int(ret), let msg = data["msg"] as? String else {
                    return .error(NetworkError.errorJSON)
                }
                guard code == 0 || code == 200 else {
                    return .error(NetworkError.detail(code: code, info: msg))
                }
                return Single.just(data["data"])
            }
            .catch ({ error -> PrimitiveSequence<SingleTrait, Any?> in
                if error is NetworkError {
                    return .error(error)
                } else if error is MoyaError {
                    guard case let MoyaError.statusCode(response) = error else {
                        return .error(NetworkError.otherError(error: error))
                    }
                    let statusCode = response.statusCode
                    let error: NetworkError
                    switch statusCode {
                    case 401:
                        error = .notAuth
                    case 404:
                        error = .notFound
                    default:
                        error = .serverBlast
                    }
                    return .error(error)
                } else {
                    return .error(NetworkError.otherError(error: error))
                }
            })
            .do(onSuccess: nil, onError: { error in
                // hud
                if let netError = error as? NetworkError {
                    switch netError {
                    case .notAuth:
                        break
                    case let .detail(code, msg):
                        print(" ==== request error ==== detail code: \(code) msg: \(msg)")
                        HUD.error(title: msg)
                    default:
                        let message = netError.localizedDescription
                        HUD.error(title: message) 
                    }
                }
                print(" ==== request error ==== \n url: \(target.path) \n error: \(error)")
            })
    }
}
