//
//  PostTests.swift
//  ceibaTests
//
//  Created by Macbook on 7/02/21.
//

import XCTest
@testable import ceiba

class PostTests: XCTestCase {
    
    var article1:Post!
    var article2:Post!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        article1 = Post(userId: 1, id: 10, title: "Articulo 1", body: "Articulo de web")
        article2 = Post(userId: 1, id: 12, title: "Articulo 2", body: "Articulo de web 2")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        article1 = nil
        article2 = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertTrue(article1.title != article2.title)
        XCTAssertEqual(article1.id, 10) // success
        XCTAssertEqual(article1.id, 35) // fail
        //XCTAssertTrue(article1.title == article2.title)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
