//
//  RegisterViewController.swift
//  SycKit_Example
//
//  Created by syc on 2021/1/5.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// 鸣谢:
// Swift - RxSwift的使用详解54（一个用户注册样例1：基本功能实现） https://www.hangge.com/blog/cache/detail_2029.html
// Swift - RxSwift的使用详解55（一个用户注册样例2：显示网络请求活动指示器） https://www.hangge.com/blog/cache/detail_2030.html

//扩展UILabel
extension Reactive where Base: UILabel {
    //让验证结果（ValidationResult类型）可以绑定到label上
    var validationResult: Binder<ValidationResult> {
        return Binder(base) { label, result in
            label.textColor = result.textColor
            label.text = result.description
        }
    }
}

/// Rx 注册
class RegisterViewController: UIViewController {
    
    //用户名输入框、以及验证结果显示标签
    let usernameField = UITextField()
    let usernameValidationLabel = UILabel()
    
    //密码输入框、以及验证结果显示标签
    let passwordField = UITextField()
    let passwordValidationLabel = UILabel()
    
    //重复密码输入框、以及验证结果显示标签
    let repeatedPasswordField = UITextField()
    let repeatedPasswordValidationLabel = UILabel()
    
    //注册按钮
    let signupButton = UIButton()
    
    // 指示器
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        setupVM()
    }
    
    /// UI
    func setupUI(){
        var y: CGFloat = 150
        usernameField.borderStyle = .roundedRect
        usernameField.frame = CGRect(x: 20, y: y, width: 200, height: 30)
        y += 40
        usernameValidationLabel.frame = CGRect(x: 20, y: y, width: 200, height: 30)
        y += 40
        passwordField.borderStyle = .roundedRect
        passwordField.frame = CGRect(x: 20, y: y, width: 200, height: 30)
        y += 40
        passwordValidationLabel.frame = CGRect(x: 20, y: y, width: 200, height: 30)
        y += 40
        repeatedPasswordField.borderStyle = .roundedRect
        repeatedPasswordField.frame = CGRect(x: 20, y: y, width: 200, height: 30)
        y += 40
        repeatedPasswordValidationLabel.frame = CGRect(x: 20, y: y, width: 200, height: 30)
        y += 40
        signupButton.setTitle("register", for: UIControlState.normal)
        signupButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        signupButton.frame = CGRect(x: 20, y: y, width: 200, height: 30)
        
        activityIndicatorView.frame = CGRect(x: 40, y: y, width: 30, height: 30)
        activityIndicatorView.hidesWhenStopped = true
        
        self.view.addSubview(usernameField)
        self.view.addSubview(usernameValidationLabel)
        self.view.addSubview(passwordField)
        self.view.addSubview(passwordValidationLabel)
        self.view.addSubview(repeatedPasswordField)
        self.view.addSubview(repeatedPasswordValidationLabel)
        self.view.addSubview(signupButton)
        self.view.addSubview(activityIndicatorView)
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "hangge register"
    }
    
    /// VM
    func setupVM(){
        //初始化ViewModel
        let viewModel = RegisterViewModel(
            input: (
                username: usernameField.rx.text.orEmpty.asDriver(),
                password: passwordField.rx.text.orEmpty.asDriver(),
                repeatedPassword: repeatedPasswordField.rx.text.orEmpty.asDriver(),
                loginTaps: signupButton.rx.tap.asSignal()
            ),
            dependency: (
                networkService: RegisterNetworkService(),
                signupService: RegiisterService()
            )
        )
        
        //用户名验证结果绑定
        viewModel.validatedUsername
            .drive(usernameValidationLabel.rx.validationResult)
            .disposed(by: disposeBag)
        
        //密码验证结果绑定
        viewModel.validatedPassword
            .drive(passwordValidationLabel.rx.validationResult)
            .disposed(by: disposeBag)
        
        //再次输入密码验证结果绑定
        viewModel.validatedPasswordRepeated
            .drive(repeatedPasswordValidationLabel.rx.validationResult)
            .disposed(by: disposeBag)
        
        //注册按钮是否可用
        viewModel.signupEnabled
            .drive(onNext: { [weak self] valid  in
                self?.signupButton.isEnabled = valid
                self?.signupButton.alpha = valid ? 1.0 : 0.3
            })
            .disposed(by: disposeBag)
        
        //当前是否正在注册
        viewModel.signingIn
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
        //当前是否正在注册
        viewModel.signingIn
            .drive(activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        //注册结果绑定
        viewModel.signupResult
            .drive(onNext: { [unowned self] result in
                self.showMessage("注册" + (result ? "成功" : "失败") + "!")
            })
            .disposed(by: disposeBag)
    }
    
    //详细提示框
    func showMessage(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
