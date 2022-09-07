//
//  BinHexOctTests.swift
//  SycKit_Tests
//
//  Created by swift-syc on 2020/11/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import SycKit

class BinHexOctTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // 2
        let binaryStr: String = "10011010010"
        // 8
        let octalStr: String = "2322"
        // 10
        let decimalInt: Int = 1234
        // 16
        let hexadecimalStr = "4D2"
        
        // MARK: 二进制
        // 二进制转八进制
        // 二进制转十进制
        let binaryToDecimal = binaryStr.yc.convertBinaryToDecimal()
        XCTAssertTrue(decimalInt == binaryToDecimal, "2:str -> 10:int = \(binaryToDecimal)")
        // 二进制转十六进制
        
        // MARK: 八进制
        // 八进制转二进制
        // 八进制转十进制
        let octalToDecimal = octalStr.yc.convertOctalToDecimal()
        XCTAssertTrue(decimalInt == octalToDecimal, "2:str -> 10:int = \(octalToDecimal)")
        // 八进制转十六进制
        
        // MARK: 十进制
        // 十进制转二进制
        let decimalToBinary = decimalInt.yc.convertDecimalToBinary()
        XCTAssertTrue(binaryStr == decimalToBinary, "10:int -> 2:str = \(decimalToBinary)")
        // 十进制转八进制
        let decimalToOctal = decimalInt.yc.convertDecimalToOctal()
        XCTAssertTrue(octalStr == decimalToOctal, "10:int -> 8:str = \(decimalToOctal)")
        // 十进制转十六进制
        let decimalToHexadecimal = decimalInt.yc.convertDecimalToHexadecimal()
        XCTAssertTrue(hexadecimalStr == decimalToHexadecimal, "10:int -> 16:str = \(decimalToHexadecimal)")
        
        
        // MARK: 十六进制
        // 十六进制转二进制
        // 十六进制转八进制
        // 十六进制转十进制
        let hexadecimalToDecimalTo = hexadecimalStr.yc.convertHexadecimalToDecimalTo()
        XCTAssertTrue(decimalInt == hexadecimalToDecimalTo, "16:str -> 10:int = \(hexadecimalToDecimalTo)")
    }
    
    /// String <--> Data
    func testStringData(){
        
        //ASCII码表
        //Bin(二进制)   Oct(八进制)   Dec(十进制)   Hex(十六进制)    缩写/字符    解释
        //0100 0001     0101         65            0x41            A         大写字母A
        //0110 0001     0141         97            0x61            a         小写字母a
        
        // 16:str -> 2:data
        let hexadecimalToBinary = "4161".yc.convertHexadecimalToBinary()
        // 2:data -> 16:str
        let binaryToHexadecimal = hexadecimalToBinary?.yc.convertBinaryToHexadecimal()
        
        print("16:str -> 2:data = \(hexadecimalToBinary)")
        print("2:data -> 16:str = \(binaryToHexadecimal)")
        
        // 2:data -> str
        let utf8Str = hexadecimalToBinary?.yc.stringValue
        XCTAssertTrue("Aa" == utf8Str, "2:data -> str = \(utf8Str)")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
