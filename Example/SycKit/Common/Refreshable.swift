//
//  Refreshable.swift
//  SycKit
//
//  Created by cityfruit on 2022/6/2.
//

import Foundation
import MJRefresh
import ReactorKit
import RxSwift

enum RefreshStatus {
    case none
    case beginRefresh
    case endRefresh
    case pullUpRefresh
    case pullSuccessHasMoreData
    case pullSuccessNoMoreData
}

enum RefreshType {
    case top
    case bottom
}

protocol Refreshable {
    var refreshStatus: BehaviorSubject<RefreshStatus> { get }
    var pageSize: Int { get }
}

extension Refreshable {
    var pageSize: Int { 20 }
}

extension Refreshable {
    
    func refreshStatusBind(to scrollView: UIScrollView, _ header: (() -> Void)? = nil, _ footer: (() -> Void)? = nil, footerAutoTriggerRefresh: Bool = true) -> Disposable {
        
        if header != nil {
            scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
                if scrollView.mj_footer?.isRefreshing ?? false {
                    // 结束 footer 刷新
                    scrollView.mj_footer?.endRefreshing()
                }
                // 请求数据
                header?()
                // 结束后, endRefreshing
            })
        }
        if footer != nil {
            if footerAutoTriggerRefresh {
                // 自动出发上拉刷新 (加载更多数据)
                scrollView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
                    if scrollView.mj_header?.isRefreshing ?? false {
                        // 关闭 header 刷新
                        scrollView.mj_header?.endRefreshing()
                    }
                    // 请求数据
                    footer?()
                    // 结束后, endRefreshing
                })
            } else {
                // 手动触发上拉刷新 (加载更多数据)
                scrollView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
                    if scrollView.mj_header?.isRefreshing ?? false {
                        // 关闭 header 刷新
                        scrollView.mj_header?.endRefreshing()
                    }
                    // 请求数据
                    footer?()
                    // 结束后, endRefreshing
                })
            }
        }

        return refreshStatus.subscribe(onNext: { status in
            switch status {
            case .none:
                scrollView.mj_header?.isHidden = true
                scrollView.mj_footer?.isHidden = true
                
            case .beginRefresh:
                scrollView.mj_header?.beginRefreshing()
                
            case .endRefresh:
                if scrollView.mj_header?.isRefreshing ?? false {
                    scrollView.mj_header?.endRefreshing()
                }
                if scrollView.mj_footer?.isRefreshing ?? false {
                    scrollView.mj_footer?.endRefreshing()
                }
                
            case .pullUpRefresh:
                scrollView.mj_footer?.beginRefreshing()
                
            case .pullSuccessHasMoreData:
                scrollView.mj_footer?.resetNoMoreData()
                
            case .pullSuccessNoMoreData:
                scrollView.mj_footer?.endRefreshingWithNoMoreData()
            }
        })
    }
}

protocol RefreshModel {
    var elementCount : Int { get }
}

extension ObservableType {
    
    func autoRefresh(refreshable: Refreshable, isHeader: Bool) -> Observable<Self.Element> {
        self.do(
            onNext: { element in
                if let item = element as? [Any] {
                    if isHeader {
                        // header 刷新
                        refreshable.refreshStatus.onNext(.endRefresh)
                    }
                    // footer 刷新
                    if item.count < refreshable.pageSize {
                        refreshable.refreshStatus.onNext(.pullSuccessNoMoreData)
                    } else {
                        refreshable.refreshStatus.onNext(.pullSuccessHasMoreData)
                    }
                } else if let item = element as? RefreshModel {
                    if isHeader {
                        // header 刷新
                        refreshable.refreshStatus.onNext(.endRefresh)
                    }
                    // footer 刷新
                    if item.elementCount < refreshable.pageSize {
                        refreshable.refreshStatus.onNext(.pullSuccessNoMoreData)
                    } else {
                        refreshable.refreshStatus.onNext(.pullSuccessHasMoreData)
                    }
                } else {
                    refreshable.refreshStatus.onNext(.endRefresh)
                }
            },afterNext: nil,
            onError: { error in
                refreshable.refreshStatus.onNext(.endRefresh)
            }, afterError: nil, onCompleted: nil, afterCompleted: nil,
            onSubscribe: {
                // 默认 beginRefresh
                //refreshable.refreshStatus.onNext(.beginRefresh)
            }, onSubscribed: nil, onDispose: nil)
    }
}
