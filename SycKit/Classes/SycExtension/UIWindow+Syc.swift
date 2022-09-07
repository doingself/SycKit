//
//  UIWindow+Syc.swift
//  SycKit
//
//  Created by syc on 2022/9/7.
//

import UIKit

public extension SycStruct where Base: UIWindow {
    /// 当前可见 vc
    /// - 用法: vc.yc.visibleVC
    var visibleVC: UIViewController? {
        return base.visibleVC
    }
}

extension UIWindow {
    
    /// 当前可见 vc
    /// - 用法: vc.visibleVC
    var visibleVC: UIViewController? {
        if let rootViewController: UIViewController = self.rootViewController {
            return UIWindow.getVisibleVC(vc: rootViewController)
        }
        return nil
    }

    private static func getVisibleVC(vc: UIViewController) -> UIViewController {
        if let navigationController = vc as? UINavigationController,
           let visibleController = navigationController.visibleViewController
        {
            return UIWindow.getVisibleVC(vc: visibleController)
        } else if let tabBarController = vc as? UITabBarController,
                  let selectedTabController = tabBarController.selectedViewController
        {
            return UIWindow.getVisibleVC(vc: selectedTabController)
        } else {
            if let presentedViewController = vc.presentedViewController {
                return UIWindow.getVisibleVC(vc: presentedViewController)
            } else {
                return vc
            }
        }
    }
}
