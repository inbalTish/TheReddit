//
//  RedditApiClientSpec.swift
//  TheReddit
//
//  Created by Inbal Tish on 25/08/2017.
//  Copyright © 2017 Inbal Tish. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockingjay
@testable import TheReddit

class RedditApiClientSpec: QuickSpec {
    
    override func spec() {
        super.spec()
        
        describe("requestRedditListing") {
            context("success") {
                it("returns Listing") {
                    var listingData: Listing?
                    let path = Bundle(for: type(of: self)).path(forResource: "GetRedditListingSuccess", ofType: "json")!
                    let data = NSData(contentsOfFile: path)!
                    self.stub(uri("https://www.reddit.com/r/ProgrammerHumor/top.json"), jsonData(data as Data))
                    
                    RedditAPIClient.requestRedditChennelListing(channelName: "ProgrammerHumor", subredditName: "top", onSuccess: { data in
                        
                        listingData = data
                    })
                    
                    expect(listingData).toEventuallyNot(beNil())
                    expect(listingData?.kind) == "Listing"
                    expect(listingData?.children.count) != 0
                    expect(listingData?.children[0].title) == "Testing"
                    expect(listingData?.children[0].kind) == "t3"
                }
            }
            
            context("error") {
                it("returns error") {
                    var returnedError: NSError?
                    let error = NSError(domain: "Reddit page not found error", code: 404, userInfo: nil)
                    self.stub(uri("https://www.reddit.com/r/ProgrammerHumor/top.json"), failure(error))
                    RedditAPIClient.requestRedditChennelListing(channelName: "ProgrammerHumor", subredditName: "top", onError: { error in
                        returnedError = error
                    })
                    
                    expect(returnedError).toEventuallyNot(beNil())
                }
            }
        }
        
    }
    
}
