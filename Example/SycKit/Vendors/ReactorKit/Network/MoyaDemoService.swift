//
//  NetworkApi.swift
//  SycKit
//
//  Created by cityfruit on 2022/6/2.
//

import Foundation
import Moya
import RxSwift

extension NetworkService {
    
    func list(page: Int, size: Int) -> Single<[ReactDemoModel]> {
        let endpoint = NetworkApi.MoyaDemoApi.list(page: page, size: size)
        let target = MultiTarget(endpoint)
        
        //provider.requestResult(target) // Completable
        //provider.requestString(target) // Single<String>
        //provider.requestObjectJson(target).mapObject(ReactDemoModel.self) // Single<ReactDemoModel>
        //provider.requestArrayJson(target).mapArray(ReactDemoModel.self) // Single<[ReactDemoModel]>
        
        return provider.requestArrayJson(target).mapArray(ReactDemoModel.self)
    }
    
    func detail(id: Int) -> Single<ReactDemoModel> {
        let endpoint = NetworkApi.MoyaDemoApi.detail(id: id)
        let target = MultiTarget(endpoint)
        return provider.requestObjectJson(target).mapObject(ReactDemoModel.self)
    }
    
    func update(id: Int, name: String) -> Completable {
        let endpoint = NetworkApi.MoyaDemoApi.update(id: id, name: name)
        let target = MultiTarget(endpoint)
        return provider.requestResult(target)
    }
}
