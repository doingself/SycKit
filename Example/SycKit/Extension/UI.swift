//
//  UI.swift
//  SycKit
//
//  Created by cityfruit on 2022/6/2.
//

import UIKit

enum UI {}

extension UI {
    
    /// window
    static var window: UIWindow? {
        if #available(iOS 13.0, *) {
            
            let scene: UIWindowScene? = UIApplication.shared.connectedScenes.first(where: { (scene: UIScene) in
                return scene.activationState == UIScene.ActivationState.foregroundActive
            }).map({ (scene: UIScene) -> UIWindowScene in
                guard let win = scene as? UIWindowScene else {
                    fatalError("UIScene is not UIWindowScene") //return (scene as! UIWindowScene)
                }
                return win
            })
            if #available(iOS 15.0, *) {
                return scene?.keyWindow
            } else {
                return scene?.windows.first
                //return (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
                //return (scene?.delegate as? SceneDelegate)?.window
            }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    /// 底部安全区域高
    static var safeAreaInsetsBottom: CGFloat {
        if let window = window {
            if #available(iOS 11.0, *) {
                return window.safeAreaInsets.bottom
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    
    static var width: CGFloat = UIScreen.main.bounds.width
    static var height: CGFloat = UIScreen.main.bounds.height
    static var navBarHeight: CGFloat { 44.0 }
    static var statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            let scene: UIWindowScene? = UIApplication.shared.connectedScenes.first(where: { (scene: UIScene) in
                return scene.activationState == UIScene.ActivationState.foregroundActive
            }).map({ (scene: UIScene) -> UIWindowScene in
                guard let win = scene as? UIWindowScene else {
                    fatalError("UIScene is not UIWindowScene") //return (scene as! UIWindowScene)
                }
                return win
            })
            return scene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.size.height
        }
    }
    
    
    // 修改全局 Dark Light 模式
    @available(iOS 13.0, *)
    static func overrideUserInterfaceStyle(style: UIUserInterfaceStyle){
        // 暗黑模式 跟随系统 unspecified
        // 在一个普通的 controlle 上设置这个属性，只会影响当前的视图
        print("当前状态: \(UITraitCollection.current.userInterfaceStyle.rawValue)")
        UI.window?.overrideUserInterfaceStyle = style
        UI.window?.rootViewController?.setNeedsStatusBarAppearanceUpdate()
    }
}
