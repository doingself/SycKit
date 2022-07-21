//
//  UIDevice+Extension.swift
//  SycKit
//
//  Created by syc on 2022/7/13.
//

import UIKit

extension UIDevice {
    var keychainIDFV: String {
        let account = (Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? "Unknown")
        let service =  (Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "Unknown")
        
        if let data = KeychainUtil.readPassword(service: service, account: account),
           let str = String(data: data, encoding: String.Encoding.utf8) {
            return str
        } else {
            let str: String
            if let idfv = self.identifierForVendor?.uuidString {
                str = idfv
            } else {
                str = UUID().uuidString
            }
            if let data = str.data(using: String.Encoding.utf8) {
                KeychainUtil.save(password: data, service: service, account: account)
            }
            return str
        }
    }
}
