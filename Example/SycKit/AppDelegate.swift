//
//  AppDelegate.swift
//  SycKit
//
//  Created by doingself@163.com on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import UIKit
import SycKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 测试 Rx
        RxSwiftReadMe().test()
        
        let isDebug = UIApplication.yc.isDebug
        let isSimulator = UIApplication.yc.isSimulator
        let isBeginXcode = UIApplication.yc.isBeginXcode
        
        print("isDebug: \(isDebug)")
        print("isSimulator: \(isSimulator)")
        print("isBeginXcode: \(isBeginXcode)")
        
        
        // 主页
//        // SceneDelegate
//        if #available(iOS 13.0, *) {
//            let scene: UIScene? = nil
//            guard let windowScene: UIWindowScene = (scene as? UIWindowScene) else { return }
//            let window = UIWindow(windowScene: windowScene)
//            self.window = window
//        }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = self.getRootViewController()
        window?.makeKeyAndVisible()
        
        // 统一设置样式
        self.setupAppearance()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate {
    /// 主页
    func getRootViewController() -> UIViewController {
        
        //let vc = ReactDemoViewController(reactor: ReactDemoViewController.Reactor())
        
        let homeVC = HomeViewController()
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "home", image: UIImage(named: "tabbaritem-me-normal"), tag: 1)
        
        let podVC = PodExampleViewController()
        let podNav = UINavigationController(rootViewController: podVC)
        podNav.tabBarItem = UITabBarItem(title: "home", image: UIImage(named: "tabbaritem-me-normal"), tag: 1)
        podNav.tabBarItem.selectedImage = UIImage(named: "tabbaritem-me-selected")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        
        
        let meVC = MeViewController()
        let meNav = UINavigationController(rootViewController: meVC)
        let meTabBarItem = UITabBarItem(title: "me", image: UIImage(named: "tabbaritem-me-normal"), tag: 3)
        meTabBarItem.selectedImage = UIImage(named: "tabbaritem-me-selected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        meTabBarItem.badgeValue = "9+"
        meTabBarItem.badgeColor = UIColor.systemGreen
        meNav.tabBarItem = meTabBarItem
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeNav, podNav, meNav]
        return tabBarController
    }
    
    /// 第三方注册
    func registerApp(){
        //WechatUtil.shared.register()
    }
    
    /// 初始化三方设置
    func setupVendors(){
        // 日志
        //LoggerUtil.setup()
        // 网络
        //ReachabilityUtil.setup()
        // 键盘
        IQKeyboardManager.shared.enable = true
    }
    
    /// 统一设置样式
    func setupAppearance(){
        
        // MARK: scrollView
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .always
        } else {
            // viewController.automaticallyAdjustsScrollViewInsets = false
        }
        
        // 暗黑模式 跟随系统 unspecified
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .unspecified
        }
        
        if #available(iOS 15.0, *) {
            // iOS 15 的 UITableView 新增了一条新属性：sectionHeaderTopPadding， 默认会给每一个 sectionHeader 增加一个高度
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
        
        // MARK: UITabBar
        if #available(iOS 13.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            UITabBar.appearance().standardAppearance = tabBarAppearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        } else {
            // 背景色
            UITabBar.appearance().barTintColor = UIColor.systemTeal
            // 文字图片颜色
            UITabBar.appearance().tintColor = UIColor.white
        }
        
        
        // MARK: UIToolbar
        if #available(iOS 13.0, *) {
            let toolBarAppearance = UIToolbarAppearance()
            UIToolbar.appearance().standardAppearance = toolBarAppearance
            if #available(iOS 15.0, *) {
                UIToolbar.appearance().scrollEdgeAppearance = toolBarAppearance
            }
        }
        
        // MARK: UIBarButtonItem
        // https://developer.apple.com/documentation/technotes/tn3106-customizing-uinavigationbar-appearance
        //let barButtonItemAppearance = UIBarButtonItemAppearance(style: .plain)
        //barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().tintColor = UIColor.systemOrange
        // systemOrange 橙色
        // systemIndigo 靛蓝
        // systemPurple 紫色
        // systemPink 粉红色
        // systemTeal 蓝绿色
        
        // MARK: UINavigationBar
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground() // 重置背景和阴影颜色
            UINavigationBar.appearance().standardAppearance = navBarAppearance; // 静止样式
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance; // 滚动样式
            UINavigationBar.appearance().compactAppearance = navBarAppearance
            if #available(iOS 15.0, *) {
                UINavigationBar.appearance().compactScrollEdgeAppearance = navBarAppearance
            }
        } else {
            // nav 背景色
            UINavigationBar.appearance().barTintColor = UIColor.systemTeal
            // nav - image 色
            UINavigationBar.appearance().tintColor = UIColor.black
            // nav title 样式
            UINavigationBar.appearance().titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
        }
        
    }
}
