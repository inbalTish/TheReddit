//
//  TheRedditTests.swift
//  TheRedditTests
//
//  Created by Inbal Tish on 25/08/2017.
//  Copyright © 2017 Inbal Tish. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import TheReddit

class TheRedditTests: XCTestCase {
    
    var systemUnderTest: ChannelViewController!
    var testsUtils = Utils()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        systemUnderTest = ChannelViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        systemUnderTest = nil
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //MARK:- ChannelViewController tests
    func testFilterPosts() {
        //Arrange
        let testCases = ["", "fo", "zzz", "nobody"]
        
        var posts = [Thing]()
        let json = testsUtils.getMockJson(fileName: "PostsDataMock")
        if let js = json?["children"] {
            for (_, subjson):(String, JSON) in js {
                let object = Thing(json: subjson)
                posts.append(object)
            }
        }
        
        for (index, element) in testCases.enumerated() {
            //Act
            let results = systemUnderTest.filterPosts(data: posts, filter: element)
            
            //Assert
            switch index {
            case 0:
                XCTAssertEqual(results.count, 0)
            case 1:
                XCTAssertEqual(results.count, 0)
            case 2:
                XCTAssertEqual(results.count, 0)
            case 3:
                XCTAssertEqual(results.count, 1)
            default:
                break
            }
        }
    }
    
}

