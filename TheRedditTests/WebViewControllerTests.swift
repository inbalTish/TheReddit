//
//  WebViewControllerTests.swift
//  TheReddit
//
//  Created by Inbal Tish on 26/08/2017.
//  Copyright © 2017 Inbal Tish. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import TheReddit


class WebViewControllerTests: XCTestCase {
    
    var systemUnderTest: ViewController!
    var posts = [Thing]()
    var testsUtils = Utils()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
//        systemUnderTest = ViewController()
        systemUnderTest = UIStoryboard(name: "WebViewControllerStory", bundle: Bundle.main).instantiateInitialViewController() as! ViewController!
        
        let json = testsUtils.getMockJson(fileName: "PostsDataMock")
        if let js = json?["children"] {
            for (_, subjson):(String, JSON) in js {
                let object = Thing(json: subjson)
                posts.append(object)
            }
        }
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
    
    //MARK:- ViewController (WebView) tests
    func testToggleFavorite() {
        //Arrange
        let post = posts[0]
        
        //Act
        systemUnderTest.toggleFavorite(data: post)
        
        //Assert
        XCTAssertTrue(systemUnderTest.getIsFavorite())
        XCTAssertEqual(UIDataManager.sharedInstance.favorites.count, 1)
        
        //Act
        systemUnderTest.toggleFavorite(data: post)
        
        //Assert
        XCTAssertFalse(systemUnderTest.getIsFavorite())
        XCTAssertEqual(UIDataManager.sharedInstance.favorites.count, 0)
    }
    
    
}
