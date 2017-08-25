//
//  RedditAPIClient.swift
//  TheReddit
//
//  Created by Inbal Tish on 25/08/2017.
//  Copyright © 2017 Inbal Tish. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RedditAPIClient: RedditAPIClientProtocol {
    
    static func requestRedditChennelListing(channelName: String,
                                            subredditName: String,
                                            onSuccess: RedditGetListingCallback? = nil,
                                            onError: ErrorCallback? = nil)
    {
        let urlString = "https://www.reddit.com/r/\(channelName)/\(subredditName).json"
        
        Alamofire.request(urlString)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.result.value {
                        let json = JSON(data)
                        onSuccess?(Listing(json: json))
                    }
                case .failure(let error):
                    onError?(error as NSError)
                }
        }
    
    }
}
