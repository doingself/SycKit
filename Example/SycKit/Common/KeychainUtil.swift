//
//  KeyChainUtil.swift
//  SycKit
//
//  Created by syc on 2022/7/13.
//

import Foundation

// https://www.advancedswift.com/secure-private-data-keychain-swift

struct KeychainUtil{
    
    @discardableResult
    static func save(password: Data, service: String, account: String) -> Bool {

        let query: [String: AnyObject] = [
            // kSecAttrService,  kSecAttrAccount, and kSecClass
            // uniquely identify the item to save in Keychain
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            
            // kSecValueData is the item value to save
            kSecValueData as String: password as AnyObject,
            // 与 iCloud 自动同步钥匙串
            kSecAttrSynchronizable as String: kCFBooleanTrue,
        ]
        
        // SecItemAdd attempts to add the item identified by
        // the query to keychain
        let status = SecItemAdd(query as CFDictionary, nil)

        // Any status other than errSecSuccess indicates the
        // save operation failed.
        return status == errSecSuccess
    }
    
    static func update(password: Data, service: String, account: String) -> Bool {
        let query: [String: AnyObject] = [
            // kSecAttrService,  kSecAttrAccount, and kSecClass
            // uniquely identify the item to update in Keychain
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            // 与 iCloud 自动同步钥匙串
            kSecAttrSynchronizable as String: kCFBooleanTrue,
        ]
        
        // attributes is passed to SecItemUpdate with
        // kSecValueData as the updated item value
        let attributes: [String: AnyObject] = [
            kSecValueData as String: password as AnyObject
        ]
        
        // SecItemUpdate attempts to update the item identified
        // by query, overriding the previous value
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)

        // Any status other than errSecSuccess indicates the
        // update operation failed.
        return status == errSecSuccess
    }
    
    static func readPassword(service: String, account: String) -> Data? {
        let query: [String: AnyObject] = [
            // kSecAttrService,  kSecAttrAccount, and kSecClass
            // uniquely identify the item to read in Keychain
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            
            // kSecMatchLimitOne indicates keychain should read
            // only the most recent item matching this query
            kSecMatchLimit as String: kSecMatchLimitOne,

            // kSecReturnData is set to kCFBooleanTrue in order
            // to retrieve the data for the item
            kSecReturnData as String: kCFBooleanTrue
        ]

        // SecItemCopyMatching will attempt to copy the item
        // identified by query to the reference itemCopy
        var itemCopy: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &itemCopy)
        
        // Any status other than errSecSuccess indicates the
        // read operation failed.
        guard status == errSecSuccess else {
            return nil
        }

        // This implementation of KeychainInterface requires all
        // items to be saved and read as Data. Otherwise,
        // invalidItemFormat is thrown
        guard let password = itemCopy as? Data else {
            return nil
        }

        return password
    }
    
    static func deletePassword(service: String, account: String) -> Bool {
        let query: [String: AnyObject] = [
            // kSecAttrService,  kSecAttrAccount, and kSecClass
            // uniquely identify the item to delete in Keychain
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            // 与 iCloud 自动同步钥匙串
            kSecAttrSynchronizable as String: kCFBooleanTrue,
        ]

        // SecItemDelete attempts to perform a delete operation
        // for the item identified by query. The status indicates
        // if the operation succeeded or failed.
        let status = SecItemDelete(query as CFDictionary)

        // Any status other than errSecSuccess indicates the
        // delete operation failed.
        return status == errSecSuccess
    }
}
