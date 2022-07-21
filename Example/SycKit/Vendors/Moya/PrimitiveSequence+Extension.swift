//
//  PrimitiveSequence+Map.swift
//  SycKit
//
//  Created by cityfruit on 2022/6/2.
//

import Foundation
import Moya
import RxSwift
import CleanJSON

extension PrimitiveSequence where Trait == SingleTrait, Element == JSONResponse {
    /// 将 JSONResult 转换为 Model
    /// - Parameter type: Model 类型
    /// - Parameter extKeyPath: 扩展节点
    func mapObject<T: Codable>(_: T.Type) -> Single<T> {
        flatMap { response -> Single<T> in
            let result: Result<T, NetworkError> = self.jsonCovertModel(json: response)
            switch result {
            case let .success(models):
                return .just(models)
            case let .failure(error):
                return .error(error)
            }
        }
    }
}

extension PrimitiveSequence where Trait == SingleTrait, Element == [JSONResponse] {
    //// 将 JSONArray 转换为 ModelArray
    /// - Parameter type: Model 类型
    func mapArray<T: Codable>(_: T.Type) -> Single<[T]> {
        flatMap { response -> Single<[T]> in
            let result: Result<[T], NetworkError> = self.jsonArrayCovertModelArray(jsonArray: response)
            switch result {
            case let .success(models):
                return .just(models)
            case let .failure(error):
                return .error(error)
            }
        }
    }
}

extension PrimitiveSequence where Trait == SingleTrait {
    func jsonArrayCovertModelArray<T: Codable>(jsonArray: Any) -> Result<[T], NetworkError> {
        // 创建解析器
        let decoder = CleanJSONDecoder()
        // 解析器将 SnakeType 转化为 HumpType
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        // 判断是否为 JSON 格式
        guard JSONSerialization.isValidJSONObject(jsonArray) else {
            return .failure(.errorJSON)
        }
        do {
            // 将 JSON 转为 JSONDate
            let jsonData = try JSONSerialization.data(withJSONObject: jsonArray, options: [])
            // 解析 JSONData 到目标
            let models = try decoder.decode([T].self, from: jsonData)
            return .success(models)
        } catch {
            return .failure(.mapError(error: error))
        }
    }

    func jsonCovertModel<T: Codable>(json: Any) -> Result<T, NetworkError> {
        // 创建解析器
        let decoder = CleanJSONDecoder()
        // 解析器将 SnakeType 转化为 HumpType
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        // 判断是否为 JSON 格式
        guard JSONSerialization.isValidJSONObject(json) else {
            return .failure(.errorJSON)
        }
        do {
            // 将 JSON 转为 JSONDate
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
            // 解析 JSONData 到目标
            let models = try decoder.decode(T.self, from: jsonData)
            return .success(models)
        } catch {
            return .failure(.mapError(error: error))
        }
    }
}
