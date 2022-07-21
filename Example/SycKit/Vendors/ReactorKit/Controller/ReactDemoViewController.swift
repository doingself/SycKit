//
//  FeedbackViewModel.swift
//  SycKit
//
//  Created by syc on 2022/7/20.
//

import UIKit
import ReactorKit
import RxCocoa
import RxSwift
import Reusable
import RxDataSources

class ReactDemoViewController: UIViewController, View {
    typealias Reactor = ReactDemoViewModel
    
    var disposeBag: DisposeBag = DisposeBag()
    
    
    init(reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        
        print("\(#function) - \(NSString(string: #file).lastPathComponent) - \(type(of: self))")
        
        self.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(#function) - \(NSString(string: #file).lastPathComponent) - \(type(of: self))")
    }
    
    private let tableView: UITableView = {
        let tab = UITableView()
        
        tab.backgroundColor = UIColor.white
        tab.estimatedRowHeight = 44
        tab.rowHeight = UITableView.automaticDimension
        tab.separatorInset = .zero
        tab.keyboardDismissMode = .onDrag
        // 在 delegate 后设置 或者设置 高度为 0.1 修复 偏移
        tab.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 0.1))
        tab.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 0.1))
        
        return tab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // MARK: scrollView
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .always
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        configUI()
        layoutUI()
    }
    /// 安全区域发生变化
    @available(iOS 11.0, *)
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        // ..
    }
}

extension ReactDemoViewController {
    func configUI() {
        self.title = "Moya + React" // 为 nil 时 backBarButtonItem.title 默认 Back
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        
        tableView.register(cellType: ReactDemoTableViewCell.self)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func layoutUI() {
        // iOS7 topLayoutGuide/bottomLayoutGuide
        // iOS9 UILayoutGuide
        // iOS11 Safe Area / safeAreaLayoutGuide
        tableView.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.top.bottom.equalToSuperview()
                make.left.right.equalTo(self.view.safeAreaLayoutGuide)
            } else {
                make.top.equalTo(self.topLayoutGuide.snp.bottom)
                make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
                make.left.right.equalToSuperview()
            }
        }
    }
}

// MARK: View
extension ReactDemoViewController {
    func bind(reactor: Reactor) {
        
        // mj refresh
        reactor.refreshStatusBind(to: tableView, {
            reactor.action.onNext(Reactor.Action.refresh)
        }, {
            reactor.action.onNext(Reactor.Action.footerRefresh)
        }, footerAutoTriggerRefresh: false)
        .disposed(by: disposeBag)
        
        // ds
        // - 自定义 TemplateSectionModel
        // - 默认 SectionModel<String, TemplateModel>
        let dataSource = RxTableViewSectionedReloadDataSource<ReactDemoSectionModel>.init { (_, tableView, indexPath, item) -> UITableViewCell in
            
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ReactDemoTableViewCell.self)
            cell.setData(model: item)
            // cell 复选框选中事件
            cell.rx.touchUpInside
                .throttle(RxTimeInterval.milliseconds(500), latest: false, scheduler: MainScheduler.instance)
                .map { Reactor.Action.update(item) }
                .bind(to: reactor.action)
                .disposed(by: cell.disposeBag)
            return cell
        }
        
        // 数据源绑定
        reactor.state.map { $0.section }
            .flatMap({ (element: [ReactDemoSectionModel]?) -> Observable<[ReactDemoSectionModel]> in
                guard let value = element else {
                    return Observable<[ReactDemoSectionModel]>.empty()
                }
                return Observable<[ReactDemoSectionModel]>.just(value)
            })
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

// MARK: UITableViewDelegate
extension ReactDemoViewController: UITableViewDelegate {
    
}
