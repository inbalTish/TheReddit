//
//  RedditAPIClientProtocol.swift
//  TheReddit
//
//  Created by Inbal Tish on 25/08/2017.
//  Copyright © 2017 Inbal Tish. All rights reserved.
//

import Foundation

typealias RedditGetListingCallback = (Listing) -> Void
typealias ErrorCallback = (NSError) -> Void

protocol RedditAPIClientProtocol {
    
    static func requestRedditChennelListing(channelName: String,
                                            subredditName: String,
                                            query: String,
                                            onSuccess: RedditGetListingCallback?,
                                            onError: ErrorCallback?)
    
}
