//
//  UIAlertController+Extension.swift
//  SycKit_Example
//
//  Created by syc on 2022/9/7.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UIAlertController {
    
    /**
     * - alert: 一个按钮
     * - confirm: 两个按钮
     */
    enum ActionStyle {
        case alert(sure: String = "确认")
        case confirm(cancel: String = "取消", sure: String = "确认")
    }
    
    /**
     创建并 present alert
     - 用法:
     UIAlertController.present(title: "提示框", message: "提示消息", preferredStyle: Style.alert, actionStyle: ActionStyle.alert(), viewController: self)
         .filter{ $0 }
         .subscribe(onNext: { isSure in
             // ...
         }).disposed(by: disposeBag)
     */
    static func present(title: String?, message: String?, preferredStyle: UIAlertController.Style,
                        actionStyle: ActionStyle, viewController: UIViewController) -> PublishSubject<Bool> {
        let clicked = PublishSubject<Bool>.init()
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        switch actionStyle {
        case .alert(let sure):
            let sureAction = UIAlertAction(title: sure, style: UIAlertAction.Style.default, handler: { action in
                clicked.onNext(true)
                clicked.onCompleted()
            })
            alertController.addAction(sureAction)
            
        case .confirm(let cancel, let sure):
            let cancelAction = UIAlertAction(title: cancel, style: UIAlertAction.Style.cancel, handler: { action in
                clicked.onNext(false)
                clicked.onCompleted()
            })
            let sureAction = UIAlertAction(title: sure, style: UIAlertAction.Style.destructive, handler: { action in
                clicked.onNext(true)
                clicked.onCompleted()
            })
            alertController.addAction(cancelAction)
            alertController.addAction(sureAction)
        }
        
        viewController.present(alertController, animated: true)
        
        return clicked
    }
}
