//
//  UserTests.swift
//  ceibaTests
//
//  Created by Macbook on 7/02/21.
//

import XCTest
@testable import ceiba

class UserTests: XCTestCase {
    
    var user1: User!
    var user2: User!
    var user3: User!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        user1 = User(id: 10, name: "Hugo", email: "hugodesarrollo@gmail.com", phone: "300044432")
        user2 = User(id: 11, name: "Hugo", email: "hugodesarrollo1@gmail.com", phone: "300044433")
        user3 = User(id: 12, name: "Hugo", email: "hugodesarrollo2@gmail.com", phone: "300044434")
    }
    

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        user1 = nil
        user2 = nil
        user3 = nil
        
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
