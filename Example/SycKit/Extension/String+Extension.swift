//
//  String+Extension.swift
//  SycKit
//
//  Created by syc on 2022/7/13.
//

import Foundation
import CommonCrypto

extension String {
    var intValue: Int? {
        return Int(self)
    }
    
    /// 字符串时间
    func dateValue(format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let fmt = DateFormatter()
        fmt.dateFormat = format
        return fmt.date(from: self)
    }
}

extension String {
    /// 按下标读取一个字符
    subscript(idx: Int) -> Character {
        return self[index(self.startIndex, offsetBy: idx)]
    }
}

// MARK: Base64 加密
extension String {
    var encodeBase64: String? {
        if let data = self.data(using: String.Encoding.utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    var decodeBase64: String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: Encoding.utf8)
        }
        return nil
    }
}

// MARK: MD5 加密
extension String {
    var md5: String {
        let utf8 = cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02x", $1) }
        
        // 1
//        let cCharArray = self.cString(using: String.Encoding.utf8)
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
//        CC_MD5(cCharArray, strLen, result)
//        let hash = NSMutableString()
//        for i in 0..<digestLen {
//            hash.appendFormat("%02x", result[i])
//        }
//        result.deallocate()
//        return hash as String
        
        // 2
//        let cCharArray = self.cString(using: .utf8)
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        var uint8Array = [UInt8](repeating: 0, count: digestLen)
//        CC_MD5(cCharArray, CC_LONG(cCharArray!.count - 1), &uint8Array)
//        let data = Data(bytes: &uint8Array, count: digestLen)
//        let base64String = data.base64EncodedString()
//        return base64String
        // 3
//        let utf8 = cString(using: .utf8)
//        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
//        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
//        return digest.reduce("") { $0 + String(format:"%02x", $1) }
    }
}

// MARK: SHA265 加密
extension String {
    /*
     SHA 的计算流程：对数字数据进行数学运算 -> 将计算出的哈希值与已知预期的哈希值进行比较 -> 从而确定数据的完整性。
     哈希值可以从任意数据段生成，但该过程不能逆向，即不能从哈希值逆向生成数据。
     */
    var sha256: String {
        let utf8 = cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        CC_SHA256(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02x", $1) }
    }
}
