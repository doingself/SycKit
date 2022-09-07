//
//  UIColorTests.swift
//  SycKit_Tests
//
//  Created by swift-syc on 2020/10/30.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import SycKit

class UIColorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // 靛青    #4B0082    75,0,130
        // 16 进制
        let color1 = UIColor.yc.build(hexString: "#4B0082", alpha: 1)
        // 10 进制
        let color2 = UIColor.yc.build(hexInt: 4915330, alpha: 1)
        // rgb
        let color3 = UIColor.yc.build(r: 75, g: 0, b: 130, a: 1)
        print("color1 ==== \(color1)")
        print("color2 ==== \(color2)")
        print("color3 ==== \(color3)")
        
        assert(color1 == color2, "靛青    #4B0082    75,0,130")
        XCTAssert(color1 == color2, "靛青    #4B0082    75,0,130")
        XCTAssertTrue(color2 == color3, "靛青    #4B0082    75,0,130")
        XCTAssertEqual(color1, color3, "靛青    #4B0082    75,0,130")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
