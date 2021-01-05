//
//  RegisterViewModel.swift
//  SycKit_Example
//
//  Created by syc on 2021/1/5.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import RxSwift
import RxCocoa


// 鸣谢:
// Swift - RxSwift的使用详解54（一个用户注册样例1：基本功能实现） https://www.hangge.com/blog/cache/detail_2029.html
// Swift - RxSwift的使用详解55（一个用户注册样例2：显示网络请求活动指示器） https://www.hangge.com/blog/cache/detail_2030.html

struct RegisterViewModel {
    //用户名验证结果
    let validatedUsername: Driver<ValidationResult>
    
    //密码验证结果
    let validatedPassword: Driver<ValidationResult>
    
    //再次输入密码验证结果
    let validatedPasswordRepeated: Driver<ValidationResult>
    
    //注册按钮是否可用
    let signupEnabled: Driver<Bool>
    
    //正在注册中
    let signingIn: Driver<Bool>
    
    //注册结果
    let signupResult: Driver<Bool>
    
    //ViewModel初始化（根据输入实现对应的输出）
    init(
        input: (
            username: Driver<String>,
            password: Driver<String>,
            repeatedPassword: Driver<String>,
            loginTaps: Signal<Void>
        ),
        dependency: (
            networkService: RegisterNetworkService,
            signupService: RegiisterService
        )) {
        
        //用户名验证
        validatedUsername = input.username
            .flatMapLatest { username in
                return dependency.signupService.validateUsername(username)
                    .asDriver(onErrorJustReturn: .failed(message: "服务器发生错误!"))
            }
        
        //用户名密码验证
        validatedPassword = input.password
            .map { password in
                return dependency.signupService.validatePassword(password)
            }
        
        //重复输入密码验证
        validatedPasswordRepeated = Driver.combineLatest(
            input.password,
            input.repeatedPassword,
            resultSelector: dependency.signupService.validateRepeatedPassword)
        
        //注册按钮是否可用
        signupEnabled = Driver.combineLatest(
            validatedUsername,
            validatedPassword,
            validatedPasswordRepeated
        ) { username, password, repeatPassword in
            username.isValid && password.isValid && repeatPassword.isValid
        }
        .distinctUntilChanged()
        
        //获取最新的用户名和密码
        let usernameAndPassword = Driver.combineLatest(input.username, input.password) {
            (username: $0, password: $1) }
        
        //用于检测是否正在请求数据
        let activityIndicator = ActivityIndicator()
        self.signingIn = activityIndicator.asDriver()
        
        //注册按钮点击结果
        signupResult = input.loginTaps.withLatestFrom(usernameAndPassword)
            .flatMapLatest { pair in  //也可考虑改用flatMapFirst
                return dependency.networkService.signup(pair.username,
                                                        password: pair.password)
                    .trackActivity(activityIndicator) //把当前序列放入signing序列中进行检测
                    .asDriver(onErrorJustReturn: false)
            }
    }
}
