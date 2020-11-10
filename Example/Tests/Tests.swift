
import SycKit
import XCTest
@testable import SycKit_Example

class Tests: XCTestCase {

    /// 继承与XCTestCase  函数测试文件开始执行的时候运行
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }

    /// 继承与XCTestCase   测试函数运行完之后执行
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    /// 测试的例子函数
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    /// 性能测试
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
