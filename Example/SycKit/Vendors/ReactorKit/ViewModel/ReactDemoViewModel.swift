//
//  FeedbackViewModel.swift
//  SycKit
//
//  Created by syc on 2022/7/20.
//

import Foundation
import ReactorKit
import RxCocoa
import RxSwift
import Differentiator

class ReactDemoViewModel: Reactor, Refreshable {
    
    private var page: Int = 1
    private var datas = [ReactDemoModel]()
    
    // MARK: Refreshable
    var refreshStatus: BehaviorSubject<RefreshStatus> = .init(value: .beginRefresh)
    var pageSize: Int { 20 }
    
    // MARK: Reactor
    //代表用户行为
    enum Action {
        case refresh
        case footerRefresh
        case detail(ReactDemoModel)
        case update(ReactDemoModel)
    }
    
    //代表状态变化
    enum Mutation {
        case section([ReactDemoModel], Bool)
        case detail(ReactDemoModel?)
        case update(Error?)
    }
    
    //代表页面状态
    struct State {
        var section: [ReactDemoSectionModel]? // SectionModel<String, ReactDemoModel>
    }
    
    //初始页面状态
    let initialState: State = State()
    
    //实现 Action -> Mutation 的转换
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            let page = 1
            return networkService.list(page: page, size: pageSize)
                .asObservable()
                .autoRefresh(refreshable: self, isHeader: true)
                .map({ [weak self] (list: [ReactDemoModel]) in
                    self?.page = page
                    return Mutation.section(list, false)
                })
        case .footerRefresh:
            let page = self.page + 1
            return networkService.list(page: page, size: pageSize)
                .asObservable()
                .autoRefresh(refreshable: self, isHeader: false)
                .map({ [weak self] (list: [ReactDemoModel]) in
                    self?.page = page
                    return Mutation.section(list, true)
                })
            
        case let .detail(model):
            return networkService.detail(id: model.id ?? 1)
                .asObservable()
                .map(Mutation.detail)
                
        case let .update(model):
            return networkService.update(id: model.id ?? 0, name: model.name ?? "")
                .andThen(Observable<Void>.just(()))
                .flatMapLatest({ _ in
                    return Observable.just(Mutation.update(nil))
                })
                .catch({ err in
                    return Observable.just(Mutation.update(err))
                })
        }
    }
    
    //实现 Mutation -> State 的转换
    func reduce(state: State, mutation: Mutation) -> State {
        //从旧状态那里复制一个新状态
        var state = state
        
        //根据状态变化设置响应的状态值
        switch mutation {
        case let .section(list, needAppend):
            if needAppend {
                self.datas.append(contentsOf: list)
            } else {
                self.datas = list
            }
            let section: [ReactDemoSectionModel] = self.datas.map{ ReactDemoSectionModel(header: "", items: [$0]) }
            state.section = section
            
        case let .detail(model):
            if let model: ReactDemoModel = model,
               let offset = self.datas.enumerated().first(where: { $0.element == model })?.offset {
                // 更新数据
                var newModel = model
                newModel.name = "is see"
                // 更新数据源
                self.datas[offset] = newModel
                
                let section: [ReactDemoSectionModel] = self.datas.map{ ReactDemoSectionModel(header: "", items: [$0]) }
                state.section = section
            }
            
        case let .update(err):
            if let err = err {
                print(err.localizedDescription)
            }
        }
        //返回新状态
        return state
    }
}

