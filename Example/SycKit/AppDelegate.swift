//
//  AppDelegate.swift
//  SycKit
//
//  Created by doingself@163.com on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import UIKit
import SycKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 统一设置样式
        self.setupAppearance()
        // 主页
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = self.getRootViewController()
        window?.makeKeyAndVisible()
        
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
        
        let homeVC = HomeViewController()
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "home", image: UIImage(named: "tabbaritem-me-normal"), tag: 1)
        
        let podVC = PodExampleViewController()
        let podNav = UINavigationController(rootViewController: podVC)
        podNav.tabBarItem = UITabBarItem(title: "home", image: UIImage(named: "tabbaritem-me-normal"), tag: 1)
        podNav.tabBarItem.selectedImage = UIImage(named: "tabbaritem-me-selected")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        
        
        let meVC = MeViewController()
        let meNav = UINavigationController(rootViewController: meVC)
        let meTabBarItem = UITabBarItem(title: "me", image: UIImage(named: "tabbaritem-me-normal"), tag: 3)
        meTabBarItem.selectedImage = UIImage(named: "tabbaritem-me-selected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        meTabBarItem.badgeValue = "9+"
        meTabBarItem.badgeColor = UIColor.systemGreen
        meNav.tabBarItem = meTabBarItem
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeNav, podNav, meNav]
        return tabBarController
    }
    
    /// 统一设置样式
    func setupAppearance(){
        // systemOrange 橙色
        // systemIndigo 靛蓝
        // systemPurple 紫色
        // systemPink 粉红色
        // systemTeal 蓝绿色
        
        // UINavigationBar
        // - UINavigationBar().tintColor = ...
        // - UINavigationBar().standardAppearance = UINavigationBarAppearance()
        // - UINavigationBar.appearance()...
        
        // nav 背景色
        UINavigationBar.appearance().barTintColor = UIColor.systemTeal
        // nav - image 色
        UINavigationBar.appearance().tintColor = UIColor.black
        // nav title 样式
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        //UITabBarController.UITabBar
        // 背景色
        UITabBar.appearance().barTintColor = UIColor.systemTeal
        // 文字图片颜色
        UITabBar.appearance().tintColor = UIColor.white
    }
}
