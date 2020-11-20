//
//  SycStruct.swift
//  SycKit
//
//  Created by syc on 10/27/2020.
//  Copyright (c) 2020 doingself@163.com. All rights reserved.
//

import Foundation

// 进制转换
//一个十进制数，无前缀，Decimal，简写为D
//一个二进制数，有0b前缀，Binary，简写为B
//一个八进制数，有0o前缀，Octal，简写为O
//一个十六进制数，有0x前缀，Hexadecimal，简写为H

// 以下都是 8
//let number1：Int = 8 // 十进制
//let number2：Int = 0b1000 // 二进制
//let number3：Int = 0x8 // 十六进制

//ASCII码表
//Bin(二进制)   Oct(八进制)   Dec(十进制)   Hex(十六进制)    缩写/字符    解释
//0100 0001     0101         65            0x41            A         大写字母A
//0110 0001     0141         97            0x61            a         小写字母a


// MARK: BinHexOct 进制转换 (Data)

extension SycStruct where Base == Data {
    
    /// Data 转 二进制
    /// NSData和NSMutableData存储的是二进制数据
    public func convertBinary() -> [UInt8] {
        /*
         https://www.jianshu.com/p/283425ff575f
        Byte *testByte = (Byte *)[data bytes];
         
        NSData *data = [NSData dataWithBytes:testByte length:sizeof(testByte)];
        //sizeof（）是c语言的一个函数，返回testbyte的字节长度
        //testByte也可以是char类型，因为：
        typedef unsigned char UInt8;
        typedef UInt8 Byte;
        */
        
        /*
        var bytes = [UInt8](base)
        let pointer: UnsafeMutablePointer<UInt8> = UnsafeMutablePointer(&bytes)
        */
        let bytes = base.withUnsafeBytes {
            [UInt8](UnsafeBufferPointer(start: $0, count: base.count))
        }
        return bytes
    }
    
    /// Data 二进制 转 十六进制 字符串
    public func convertBinaryToHexadecimal(format: Int = 2) -> String {
        //return base.map { String(format: "%02X", $0) }.joined(separator: "")
        return base.map { String(format: "%0\(format)X", $0) }.joined(separator: "")
    }
}

// MARK: BinHexOct 进制转换 (String)
extension SycStruct where Base == String {
    
    /// 十六进制字符串 转 Data 二进制
    /// - 注: 不是 string.data(using: String.Encoding.utf8)
    public func convertHexadecimalToBinary() -> Data? {
        var data = Data(capacity: base.count / 2)
        do {
            let regex = try NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
            regex.enumerateMatches(in: base, range: NSMakeRange(0, base.utf16.count)) { match, flags, stop in
                let byteString = (base as NSString).substring(with: match!.range)
                var num = UInt8(byteString, radix: 16)!
                data.append(&num, count: 1)
            }
            guard data.count > 0 else { return nil }
            return data
        } catch {
            return nil
        }
    }
    
    /// String 二进制 转 十进制
    public func convertBinaryToDecimal() -> Int {
        var sum:Int = 0
        for c in base {
            if let number = Int(String(c)){
                sum = sum * 2 + number
            }
        }
        return sum
    }
    
    /// String 八进制 转 十进制
    public func convertOctalToDecimal() -> Int {
        var sum:Int = 0
        for c in base {
            if let number = Int(String(c)){
                sum = sum * 8 + number
            }
        }
        return sum
    }
    
    /// String 十六进制 转 十进制
    public func convertHexadecimalToDecimalTo() -> Int {
        /*
        let str = base.uppercased()
        var sum = 0
        for i in str.utf8 {
            // 0-9 从48开始
            sum = sum * 16 + Int(i) - 48
            // A-Z 从65开始，但有初始值10，所以应该是减去55
            if i >= 65 {
                sum -= 7
            }
        }
        return sum
        */
        
        var result:UInt32 = 0
        Scanner.init(string: base).scanHexInt32(&result)
        return Int(result)
    }
}


// MARK: BinHexOct 进制转换 (Int)
extension SycStruct where Base == Int {
    
    /// Int 十进制 转 二进制
    public func convertDecimalToBinary() -> String {
        //radix at least 2 and at most 36. The default is 10.
        return String(base, radix: 2, uppercase: true)
    }
    
    /// Int 十进制 转 八进制
    public func convertDecimalToOctal() -> String {
        //return String(format: "%0O", base)
        return String(base, radix: 8, uppercase: true)
    }
    
    /// Int 十进制 转 十六进制
    public func convertDecimalToHexadecimal() -> String {
        //return String(format: "%0X", base)
        return String(base, radix: 16, uppercase: true)
    }
}
