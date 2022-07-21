//
//  MBProgressHUDUtil.swift
//  SycKit
//
//  Created by syc on 2022/7/7.
//

import UIKit
import MBProgressHUD

struct HUD {
    
    static func show(){
        if Thread.isMainThread {
            guard let view = UI.window else { return }
            MBProgressHUD.hide(for: view, animated: false)
            MBProgressHUD.showAdded(to: view, animated: true)
            
        } else {
            DispatchQueue.main.async {
                guard let view = UI.window else { return }
                MBProgressHUD.hide(for: view, animated: false)
                MBProgressHUD.showAdded(to: view, animated: true)
            }
        }
    }
    
    static func hide(){
        if Thread.isMainThread {
            guard let view = UI.window else { return }
            MBProgressHUD.hide(for: view, animated: true)
        } else {
            DispatchQueue.main.async {
                guard let view = UI.window else { return }
                MBProgressHUD.hide(for: view, animated: true)
            }
        }
    }
    
    static func success(title: String? = nil, message: String? = nil){
        guard let view = UI.window else { return }
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = MBProgressHUDMode.customView
        //hud.customView = UIImageView(image: image)
        if let title = title {
            hud.label.text = title
        }
        if let message = message {
            hud.detailsLabel.text = message
        }
        hud.hide(animated: true, afterDelay: 2)
    }
    
    static func error(title: String? = nil, message: String? = nil){
        guard let view = UI.window else { return }
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = MBProgressHUDMode.customView
        //hud.customView = UIImageView(image: image)
        if let title = title {
            hud.label.text = title
        }
        if let message = message {
            hud.detailsLabel.text = message
        }
        hud.hide(animated: true, afterDelay: 2)
    }
    
}
