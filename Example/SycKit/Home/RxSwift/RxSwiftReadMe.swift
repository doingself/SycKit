//
//  TabViewRxViewModel.swift
//  SycKit_Example
//
//  Created by syc on 2021/1/4.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx

// 鸣谢: https://www.hangge.com
/*
 
 Observable<T> (可观察序列) 这个类就是 Rx 框架的基础，我们可以称它为可观察序列。它的作用就是可以异步地产生一系列的 Event（事件），即一个 Observable<T> 对象会随着时间推移不定期地发出 event(element : T) 这样一个东西。而且这些 Event 还可以携带数据，它的泛型 <T> 就是用来指定这个 Event 携带的数据的类型。

 Observer (订阅者) 来订阅它，这样这个订阅者才能收到 Observable<T> 不时发出的 Event。
 Observer (观察者) 的作用就是监听事件，然后对这个事件做出响应。或者说任何响应事件的行为都是观察者。

 Event 就是一个枚举，(next error completed) 也就是说一个 Observable 是可以发出 3 种不同类型的 Event 事件
 
 Subjects 既是 Observer (观察者)，也是 Observable (可观察序列)

*/

/// rx table view VM (Rx + RxDataSources)

struct RxSwiftReadMe {
    // 管理多个订阅行为的销毁
    let disposeBag = DisposeBag()
    
    let label = UILabel()
}

// MARK: Observable
extension RxSwiftReadMe {
    /// 可观察序列
    func testObservableCreate(){
        
        //这个block有一个回调参数observer就是订阅这个Observable对象的订阅者
        //当一个订阅者订阅这个Observable对象的时候，就会将订阅者作为参数传入这个block来执行一些内容
        let observable = Observable<String>.create{observer in
            //对订阅者发出了.next事件，且携带了一个数据"hangge.com"
            observer.onNext("hangge.com")
            //对订阅者发出了.completed事件
            observer.onCompleted()
            //因为一个订阅行为会有一个Disposable类型的返回值，所以在结尾一定要returen一个Disposable
            return Disposables.create()
        }
        
        // 订阅测试
        // 创建观察者最直接的方法就是在 Observable 的 subscribe 方法后面描述当事件发生时，需要如何做出响应。
        observable.subscribe({ (event) in
            print(event)
        }).disposed(by: disposeBag)
        
        let _ = Observable<Int>.timer(3, scheduler: MainScheduler.instance)
        let _ = Observable<Int>.empty()
        let _ = Observable<String>.just("A")
        let _ = Observable.from(["A", "B", "C"])
        let of = Observable.of("A", "B", "C")
        of.do(onNext: { (element) in
            // do(onNext:) 在 subscribe(onNext:) 前调用
            print("do onNext \(element)")
        }, afterNext: nil, onError: nil, afterError: nil, onCompleted: {
            // do(onCompleted:) 在 subscribe(onCompleted:) 前调用
            print("do onCompleted")
        }, afterCompleted: nil, onSubscribe: nil, onSubscribed: nil, onDispose: nil)
        .subscribe(onNext: { (element) in
            print("subscribe onNext \(element)")
        }, onError: nil, onCompleted: {
            print("subscribe onCompleted")
        }, onDisposed: nil)
        // 手动取消一个订阅行为。
        .dispose()

    }
    
    // Swift - RxSwift的使用详解17（特征序列1：Single、Completable、Maybe）https://www.hangge.com/blog/cache/detail_1939.html
    // Single 是 Observable 的另外一个版本。但它不像 Observable 可以发出多个元素，它要么只能发出一个元素，要么产生一个 error 事件。
    // Completable 是 Observable 的另外一个版本。不像 Observable 可以发出多个元素，它要么只能产生一个 completed 事件，要么产生一个 error 事件。
    // Maybe 同样是 Observable 的另外一个版本。它介于 Single 和 Completable 之间，它要么只能发出一个元素，要么产生一个 completed 事件，要么产生一个 error 事件。
    
    // Swift - RxSwift的使用详解18（特征序列2：Driver）https://www.hangge.com/blog/cache/detail_1942.html
    // Driver 是 Observable (特征序列), drive 方法只能被 Driver 调用, 不会产生 error 事件, 一定在主线程监听（MainScheduler）, 共享状态变化（shareReplayLatestWhileConnected）
    // Binder 将控件属性变成 Observer (观查者), 不会处理错误事件 确保绑定都是在给定 Scheduler 上执行（默认 MainScheduler）
    
    // Swift - RxSwift的使用详解19（特征序列3：ControlProperty、 ControlEvent）https://www.hangge.com/blog/cache/detail_1943.html
    
}

// MARK: Observer
extension RxSwiftReadMe {
    /// 观察者
    func testObserver(){
        // 可观察序列
        let observable = Observable.of("A", "B", "C")
        
        //观察者 1
        observable.subscribe({ (event) in
            print(event)
        })
        
        
        //观察者 2
        let observer: AnyObserver<String> = AnyObserver { (event) in
            switch event {
            case .next(let data):
                print(data)
            case .error(let error):
                print(error)
            case .completed:
                print("completed")
            }
        }
        observable.subscribe(observer)
        
        
        //观察者 3
        observable.bind(to: observer).disposed(by: disposeBag)
        
        //观察者 4
        let binder: Binder<String> = Binder(label) { (view, text) in
            //收到发出的索引数后显示到label上
            view.text = text
        }
        observable.bind(to: binder).disposed(by: disposeBag)
        
        //观察者 5
        observable.bind(to: label.rx.text).disposed(by: disposeBag)
    }
}

// MARK: Subjects
extension RxSwiftReadMe {
    
    // Subjects，分别为：PublishSubject BehaviorSubject ReplaySubject Variable(废弃) BehaviorRelay
    
    func testPublishSubject() {
        
        // PublishSubject 的订阅者从他们开始订阅的时间点起，可以收到订阅后 Subject 发出的新 Event，而不会收到他们在订阅前已发出的 Event。
        //创建一个PublishSubject
        let publishSubject = PublishSubject<String>()
        
        //由于当前没有任何订阅者，所以这条信息不会输出到控制台
        publishSubject.onNext("111")
        
        // 只能观察到 222 和 completed
        publishSubject.subscribe(onNext: { string in
            print("publishSubject onNext: ", string)
        }, onCompleted:{
            print("publishSubject onCompleted")
        }).disposed(by: disposeBag)
         
        //当前有1个订阅，则该信息会输出到控制台
        publishSubject.onNext("222")
        //让subject结束
        publishSubject.onCompleted()
    }
    
    func testBehaviorSubject(){
        // BehaviorSubject 需要通过一个默认初始值来创建。当一个订阅者来订阅它的时候，这个订阅者会立即收到 BehaviorSubjects 上一个发出的 event。
        
        //创建一个BehaviorSubject
        let subject = BehaviorSubject(value: "111")
         
        //第1次订阅subject
        subject.subscribe { event in
            print("BehaviorSubject event: ", event)
        }.disposed(by: disposeBag)
         
        //发送next事件
        subject.onNext("222")
         
        //发送error事件
        subject.onError(NSError(domain: "local", code: 0, userInfo: nil))
         
        //第2次订阅subject, 只能观察到 error
        subject.subscribe { event in
            print("第2次订阅：", event)
        }.disposed(by: disposeBag)
    }
    
    func testReplaySubject(){
        // ReplaySubject 在创建时候需要设置一个 bufferSize，表示它对于它发送过的 event 的缓存个数。
        // 比如一个 ReplaySubject 的 bufferSize 设置为 2，它发出了 3 个 .next 的 event，那么它会将后两个（最近的两个）event 给缓存起来。此时如果有一个 subscriber 订阅了这个 ReplaySubject，那么这个 subscriber 就会立即收到前面缓存的两个 .next 的 event。
        
        //创建一个bufferSize为2的ReplaySubject
        let subject = ReplaySubject<String>.create(bufferSize: 2)
         
        //连续发送3个next事件
        subject.onNext("111")
        subject.onNext("222")
        subject.onNext("333")
         
        //让subject结束
        subject.onCompleted()
        
        // 观察到  222   333  +  completed
        subject.subscribe { event in
            print("ReplaySubject: ", event)
        }.disposed(by: disposeBag)
    }
    
    func testBehaviorRelay(){
        // BehaviorRelay 是对 BehaviorSubject 的封装
        // BehaviorRelay 与 BehaviorSubject 不同的是，不需要也不能手动给 BehaviorReply 发送 completed 或者 error 事件来结束它（BehaviorRelay 会在销毁时也不会自动发送 .complete 的 event）。
        // BehaviorRelay 有一个 value 属性，我们通过这个属性可以获取最新值。而通过它的 accept() 方法可以对值进行修改。
        
        //创建一个初始值为111的BehaviorRelay
        let subject = BehaviorRelay<String>(value: "111")
         
        //修改value值
        subject.accept("222")
         
        // 观察到 222  333
        subject.asObservable().subscribe {
            print("BehaviorRelay: ", $0)
        }.disposed(by: disposeBag)
         
        //修改value值
        subject.accept("333")
        
        // 获取 value
        print(subject.value)
    }
}

// MARK: 调度器
extension RxSwiftReadMe {
    // Swift - RxSwift的使用详解20（调度器、subscribeOn、observeOn） https://www.hangge.com/blog/cache/detail_1940.html
    func testScheduler(){
        let publishSubject = PublishSubject<String>()
        publishSubject.onNext("111")
        
        publishSubject
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated)) //后台构建序列
            .observeOn(MainScheduler.instance)  //主线程监听并处理序列结果
            .subscribe(onNext: { string in
            print("publishSubject onNext: ", string)
        }, onCompleted:{
            print("publishSubject onCompleted")
        }).disposed(by: disposeBag)
    }
}

// MARK: 操作符
extension RxSwiftReadMe {
    
    // buffer 方法作用是缓冲组合，第一个参数是缓冲时间，第二个参数是缓冲个数，第三个参数是线程。 该方法简单来说就是缓存 Observable 中发出的新元素，当元素达到某个数量，或者经过了特定的时间，它就会将这个元素集合发送出来。

    // window 操作符和 buffer 十分相似。不过 buffer 是周期性的将缓存的元素集合发送出来，而 window 周期性的将元素集合以 Observable 的形态发送出来。同时 buffer 要等到元素搜集完毕后，才会发出元素序列。而 window 可以实时发出元素序列。

    // map 该操作符通过传入一个函数闭包把原来的 Observable 序列转变为一个新的 Observable 序列。
    
    // flatMap "拍扁"（降维）成一个 Observable 序列。
    
    // flatMapLatest 与 flatMap 的唯一区别是：flatMapLatest 只会接收最新的 value 事件。
    
    // flatMapFirst 与 flatMapLatest 正好相反：flatMapFirst 只会接收最初的 value 事件。
    
    // concatMap 与 flatMap 的唯一区别是：等待前一个 Observable 产生完成事件后，才对后一个 Observable 进行订阅。
    
    // scan 就是先给一个初始化的数，然后不断的拿前一个结果和最新的值进行处理操作。 (参考 reduce)
    
    // groupBy 操作符将源 Observable 分解为多个子 Observable，然后将这些子 Observable 发送出来。
    
    // filter 该操作符就是用来过滤掉某些不符合要求的事件。
    
    // distinctUntilChanged 该操作符用于过滤掉连续重复的事件。
    
    // single 限制只发送一次事件，或者满足条件的第一个事件。如果存在有多个事件或者没有事件都会发出一个 error 事件。如果只有一个事件，则不会发出 error 事件。
    
    // elementAt 该方法实现只处理在指定位置的事件。
    
    // ignoreElements 该操作符可以忽略掉所有的元素，只发出 error 或 completed 事件。
    
    // take 该方法实现仅发送 Observable 序列中的前 n 个事件，在满足数量之后会自动 .completed。
    
    // takeLast 该方法实现仅发送 Observable 序列中的后 n 个事件。
    
    // skip 该方法用于跳过源 Observable 序列发出的前 n 个事件。
    
    // debounce 操作符可以用来过滤掉高频产生的元素，它只会发出这种元素：该元素产生后，一段时间内没有新元素产生。换句话说就是，队列中的元素如果和下一个元素的间隔小于了指定的时间间隔，那么这个元素将被过滤掉。debounce 常用在用户输入的时候，不需要每个字母敲进去都发送一个事件，而是稍等一下取最后一个事件。
    
    // amb 当传入多个 Observables 到 amb 操作符时，它将取第一个发出元素或产生事件的 Observable，然后只发出它的元素。并忽略掉其他的 Observables。
    
    // takeWhile 该方法依次判断 Observable 序列的每一个值是否满足给定的条件。 当第一个不满足条件的值出现时，它便自动完成。
    
    // takeUntil 除了订阅源 Observable 外，通过 takeUntil 方法我们还可以监视另外一个 Observable， 即 notifier。如果 notifier 发出值或 complete 通知，那么源 Observable 便自动完成，停止发送事件。
    
    // skipWhile 该方法用于跳过前面所有满足条件的事件。
    
    // skipUntil 与 takeUntil 相反的是。源 Observable 序列事件默认会一直跳过，直到 notifier 发出值或 complete 通知。
    
    // Swift - RxSwift的使用详解11（结合操作符：startWith、merge、zip等）https://www.hangge.com/blog/cache/detail_1930.html
    
    // Swift - RxSwift的使用详解12（算数&聚合操作符：toArray、reduce、concat）https://www.hangge.com/blog/cache/detail_1934.html
    
    // Swift - RxSwift的使用详解13（连接操作符：connect、publish、replay、multicast）https://www.hangge.com/blog/cache/detail_1935.html
    
    // Swift - RxSwift的使用详解14（其他操作符：delay、materialize、timeout等）https://www.hangge.com/blog/cache/detail_1950.html
    
    // Swift - RxSwift的使用详解15（错误处理）https://www.hangge.com/blog/cache/detail_1936.html
    
    // Swift - RxSwift的使用详解16（调试操作）https://www.hangge.com/blog/cache/detail_1937.html
    
    // Swift - RxSwift的使用详解27（双向绑定：<->）https://www.hangge.com/blog/cache/detail_1974.html
    
    func testOperator(){
        Observable.of(1, 2, 3, 4)
            .take(2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
}

// MARK: UI
extension RxSwiftReadMe {
    // Swift - RxSwift的使用详解21（UI控件扩展1：UILabel）https://www.hangge.com/blog/cache/detail_1963.html
    // Swift - RxSwift的使用详解22（UI控件扩展2：UITextField、UITextView）https://www.hangge.com/blog/cache/detail_1964.html
    // Swift - RxSwift的使用详解23（UI控件扩展3：UIButton、UIBarButtonItem）https://www.hangge.com/blog/cache/detail_1969.html
    // Swift - RxSwift的使用详解24（UI控件扩展4：UISwitch、UISegmentedControl）https://www.hangge.com/blog/cache/detail_1970.html
    // Swift - RxSwift的使用详解25（UI控件扩展5：UIActivityIndicatorView、UIApplication）https://www.hangge.com/blog/cache/detail_1971.html
    // Swift - RxSwift的使用详解26（UI控件扩展6：UISlider、UIStepper）https://www.hangge.com/blog/cache/detail_1972.html
    // Swift - RxSwift的使用详解28（UI控件扩展7：UIGestureRecognizer）https://www.hangge.com/blog/cache/detail_1975.html
    // Swift - RxSwift的使用详解29（UI控件扩展8：UIDatePicker）https://www.hangge.com/blog/cache/detail_1973.html
    
    // Swift - RxSwift的使用详解30（UITableView的使用1：基本用法）https://www.hangge.com/blog/cache/detail_1976.html
    // Swift - RxSwift的使用详解31（UITableView的使用2：RxDataSources）https://www.hangge.com/blog/cache/detail_1982.html
    // Swift - RxSwift的使用详解32（UITableView的使用3：刷新表格数据）https://www.hangge.com/blog/cache/detail_1987.html
    // Swift - RxSwift的使用详解33（UITableView的使用4：表格数据的搜索过滤）https://www.hangge.com/blog/cache/detail_1994.html
    // Swift - RxSwift的使用详解34（UITableView的使用5：可编辑表格）https://www.hangge.com/blog/cache/detail_1995.html
    // Swift - RxSwift的使用详解35（UITableView的使用6：不同类型的单元格混用）https://www.hangge.com/blog/cache/detail_1996.html
    // Swift - RxSwift的使用详解36（UITableView的使用7：样式修改）https://www.hangge.com/blog/cache/detail_1984.html
    
    // Swift - RxSwift的使用详解37（UICollectionView的使用1：基本用法）https://www.hangge.com/blog/cache/detail_2004.html
    // Swift - RxSwift的使用详解38（UICollectionView的使用2：RxDataSources）https://www.hangge.com/blog/cache/detail_2005.html
    // Swift - RxSwift的使用详解39（UICollectionView的使用3：刷新集合数据）https://www.hangge.com/blog/cache/detail_2008.html
    // Swift - RxSwift的使用详解40（UICollectionView的使用4：样式修改）https://www.hangge.com/blog/cache/detail_2009.html
    
    // Swift - RxSwift的使用详解41（UIPickerView的使用）https://www.hangge.com/blog/cache/detail_1983.html
    // Swift - RxSwift的使用详解42（[unowned self] 与 [weak self]）https://www.hangge.com/blog/cache/detail_1993.html
}

// MARK: Foundation
extension RxSwiftReadMe {
    // Swift - RxSwift的使用详解43（URLSession的使用1：请求数据）https://www.hangge.com/blog/cache/detail_2010.html
    // Swift - RxSwift的使用详解44（URLSession的使用2：结果处理、模型转换）https://www.hangge.com/blog/cache/detail_2011.html
}

// MARK: MVVM
extension RxSwiftReadMe {
    // Swift - RxSwift的使用详解51（MVVM架构演示1：基本介绍、与MVC比较）https://www.hangge.com/blog/cache/detail_2023.html
    // Swift - RxSwift的使用详解52（MVVM架构演示2：使用Observable样例）https://www.hangge.com/blog/cache/detail_2019.html
    // Swift - RxSwift的使用详解53（MVVM架构演示3：使用Driver样例）https://www.hangge.com/blog/cache/detail_2024.html
    
}


extension RxSwiftReadMe {
    func test(){
        
        let publishSubject = PublishSubject<String>()
        
        //由于当前没有任何订阅者，所以这条信息不会输出到控制台
        publishSubject.onNext("111")
        publishSubject.onNext("222")
        
        
        // subscribe - do | bind - driver
        publishSubject.subscribe{ print("subscribe \($0)")}.disposed(by: disposeBag)
        publishSubject.do { print("do1 \($0)")}.asObservable().bind(to: label.rx.text).disposed(by: disposeBag)
        publishSubject.do { print("do2 \($0)")}.asDriver(onErrorJustReturn: "000").drive(label.rx.text).disposed(by: disposeBag)
        
        publishSubject.onNext("333")
        publishSubject.onNext("444")
        publishSubject.onCompleted()
        
    }
}
